//
//  ViewController.swift
//  AnalyticsPrototypicalPrototypeSwiftStyle
//
//  Created by Kevin Rafferty on 6/9/15.
//  Copyright © 2015 JunGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum JSONError: ErrorType {
        
        case JSONArrayError
        
        case JSONParsingError
        
        case JSONDictionaryError
        
        case JSONEmptyArrayError
        
        case JSONSerializaionError
        
    }
    
    // MARK: -
    // MARK: UILabel Properties
    // MARK: -
    
    @IBOutlet weak var averageeCPMLabel: UILabel!
    
    // MARK: -
    // MARK: UITextField Properties
    // MARK: -
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    // MARK: -
    // MARK: View Life Cycle
    // MARK: -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -
    // MARK: IBAction Methods
    // MARK: -
    
    @IBAction func onFetchInformationButtonPressed(sender: AnyObject) {
        
        self.retrieveAdCompletedInformation()
    }
    
    @IBAction func onStartDateBeginEditing(sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        // We want the UIDatePicker to be accessible for UI Testing
        datePickerView.accessibilityActivate()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("startDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func onEndDateBeginEditing(sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        // We want the UIDatePicker to be accessible for UI Testing
        datePickerView.accessibilityActivate()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("endDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // MARK: -
    // MARK: Selector Methods
    // MARK: -
    
    func startDatePickerValueChanged(sender: UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        self.startDateTextField.text = dateformatter.stringFromDate(sender.date)
    }
    
    func endDatePickerValueChanged(sender: UIDatePicker) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        self.endDateTextField.text = dateformatter.stringFromDate(sender.date)
    }
    
    // MARK: -
    // MARK: Helper Methods
    // MARK: -
    
    func retrieveAdCompletedInformation() {
        
        JUNWebServices().GETAdCompletedInformation {(data: NSData) -> Void in
            
            self.parseJSONDataForAdCompleted(data)
        }
    }
    
    func parseJSONDataForAdCompleted(data: NSData) {
        
        do {
            
            let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
//            print("JSON data - \(JSON)")
            
            /*
             *
             * Note: A compiler warning will appear when running XCUITests stating "Cast from
             *       'XCUIElement' to unrelated type '' always fails. This has been experienced
             *       by another developer who attended WWDC 2015 an has filed an open radar issue
             *       which can be seen here: http://www.openradar.me/21349340
             *
             */
            
            guard let JSONArray: NSArray = JSON["result"] as? NSArray else {
                
                throw JSONError.JSONSerializaionError
            }
            
            if JSONArray.count <= 0 {
                
                throw JSONError.JSONEmptyArrayError
            }
            
            var sum: NSInteger = 0
            var averageeCPM: NSInteger = 0
            
            for var index = 0; index < JSONArray.count; ++index {
                
                guard let dictionary: NSDictionary = JSONArray[index] as? NSDictionary else {
                    
                    throw JSONError.JSONArrayError
                }
                
                guard let number: NSNumber = dictionary["ad_provider_eCPM"] as? NSNumber else {
                    
                    throw JSONError.JSONDictionaryError
                }
                
                sum += number.integerValue
            }
            
            averageeCPM = sum / JSONArray.count
            
            // Update the eCPM UILabel back on the main thread
            dispatch_async(dispatch_get_main_queue()) {
                
                self.averageeCPMLabel.text = "\(averageeCPM)"
            }
            
        } catch JSONError.JSONArrayError {
            
            print("An error has occurred accessing the NSArray object.");
            
        } catch JSONError.JSONParsingError {
            
            print("An error has occurred parsing the JSON NSData.");
            
        } catch JSONError.JSONDictionaryError {
            
            print("An error has occurred accessing the NSDictionary object.");
            
        } catch JSONError.JSONEmptyArrayError {
            
            print("An error has occured parsing the JSON NSData, an empty NSArray object was encountered.")
            
        } catch JSONError.JSONSerializaionError {
            
            print("An error has occurred accessing the Foundation object returned from the serialized JSON data.");
            
        } catch {
            
            print("An unknown error has occurred parsing the JSON NSData.");
        }
    }
}