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
}