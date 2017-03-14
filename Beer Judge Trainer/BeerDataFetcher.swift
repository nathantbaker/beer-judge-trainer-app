//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

public class BeerDataFetcher {
    
    func GetResource(apiResource: String) {
        print("you called get brewery names function")
        
        
        // Send HTTP GET Request
        

        // Define server side script URL
        let apiRoot = "http://api.cancanawards.com/"
        // Add one parameter
        let urlWithParams = apiRoot + apiResource + "/"
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            
            print(responseString!)
        }
        task.resume()
        
        
    }
    
}

