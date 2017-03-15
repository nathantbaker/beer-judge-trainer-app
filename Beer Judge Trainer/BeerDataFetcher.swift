//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

public class BeerDataFetcher {
    
    func PullDownJSON(endpoint: String, completionHandler: @escaping (_ responseData: String) -> ()) {
        print("GetResource function")
        
        let apiRoot = "http://api.cancanawards.com/"
        // Add one parameter
        let urlWithParams = apiRoot + endpoint + "/"
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
            
            // Parse results as a string
            let results = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            completionHandler(results as! String)
        
        }
        task.resume()
        
        
    }
    
    func GetResource(endpoint: String) {
        self.PullDownJSON(endpoint: endpoint) {
            responseData in
            print("Data: \(responseData)")
        }
    }
    
}

