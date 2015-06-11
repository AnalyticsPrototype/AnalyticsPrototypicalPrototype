//
//  JUNWebServices.swift
//  AnalyticsPrototypicalPrototype
//
//  Created by Kevin Rafferty on 6/8/15.
//  Copyright (c) 2015 JunGroup. All rights reserved.
//

import Foundation


class JUNWebServices: NSObject {
    
    // mark -
    // mark Constants
    // mark -
    
    let kGETAdCompletedInformation = "https://api.keen.io/3.0/projects/550b015646f9a745baaab265/queries/extraction?api_key=f6ac29330c9dbee3fb1b249a5567236917317e5fab809eb871b35c6413a445dfad8476e9d7462b69f9d31e7b96d8d16a9311fd26d7203825d2f03126e5bb16a9f47666a21e8cfcf5c546a3757c019b8375857eda35ce3fd972a3cebd8b7c6f155985db076c4cdd6fd0412dc2e2ccaa15&event_collection=ad_completed";
    
    // mark -
    // mark Web Service Methods
    // mark -
    
    /**---------------------------------------------------------------------------------------
    * @name JUN Web Service Methods
    * ---------------------------------------------------------------------------------------
    */
    
    /** This method will get the Ad Completed Event Collection information such as Ad Provider eCPM, Ad Provider Name, Virtual Currency Reward, etc.
    *
    *  A callback handler will provide the serialized JSON data returned from Keen in an NSDictionary format
    */
    func GETAdCompletedInformation(requestCompletionHandler: (data: NSData) -> Void) {
        
        // Create the NSURL constant from the URL path String
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: String(format: "%@&timeframe=previous_%i_hours", kGETAdCompletedInformation, 7))!)
        
        // Create the NSURLSession constant
        let session: NSURLSession = NSURLSession.sharedSession();
        
        // Create the NSURLSessionDataTask constant
        let task = session.dataTaskWithRequest(request){(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if error != nil {
                
                print("An error occurred while retrieving the Ad Completed JSON - \(error!.localizedDescription)");
            }
            
            requestCompletionHandler(data: data!);
        }
        
        // The task constant is just an object with all these properties set
        // In order to actually make the web request we need to call resume.
        task!.resume();
    }
}