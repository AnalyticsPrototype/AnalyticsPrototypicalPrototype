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
        
        case JSONParsingError
        
        case JSONArrayError
        
        case JSONDictionaryError
        
    }
    
    // mark -
    // mark UILabel Properties
    // mark -
    
    @IBOutlet weak var averageeCPMLabel: UILabel!
    
    // mark -
    // mark UITextField Properties
    // mark -
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    // mark -
    // mark View Life Cycle
    // mark -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // mark -
    // mark IBAction Methods
    // mark -
    
    @IBAction func onFetchInformationButtonPressed(sender: AnyObject) {
        
        JUNWebServices().GETAdCompletedInformation {(data: NSData) -> Void in
            
            do {
                
                let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                
                guard let JSONArray: NSArray = JSON["result"] as? NSArray else {
                    
                    throw JSONError.JSONArrayError
                }
                
                var sum: NSInteger = 0
                var averageeCPM: NSInteger = 0
                
                for var index = 0; index < JSONArray.count; ++index {
                    
                    guard let dictionary: NSDictionary = JSONArray[index] as? NSDictionary else {
                        
                        throw JSONError.JSONDictionaryError
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
                
            } catch {
                
                print("An error has occurred parsing the JSON NSData.");
            }
        }
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
    
    // mark -
    // mark Selector Methods
    // mark -
    
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
}