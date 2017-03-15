//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

public class BeerDataFetcher {
    
    var breweries = ""
    var beer = ""
    
    func GetResource(endpoint: String, completionHandler: @escaping (_ responseData: String) -> ()) {
        
        //  build url
        let apiRoot = "http://api.cancanawards.com/"
        let urlWithParams = apiRoot + endpoint + "/"
        let myUrl = NSURL(string: urlWithParams);
        
        // build request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // error handling
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // parse results as a string
            let results = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            // return data
            completionHandler(results as! String)
        
        }
        task.resume()
    }
    
    func GetBreweryList() {
        self.GetResource(endpoint: "breweries") {
            // when brewery data is fetched, store it locally
            data in self.breweries = data
        }
    }
    
    func GetBeerList() {
        self.GetResource(endpoint: "beers") {
            // when beer data is fetched, store it locally
            data in self.beer = data
        }
    }
    
    func ReturnString() -> ((String) -> String) {

        func stringBuilder(input: String) -> String {
            return input + "!!!"
        }
        return stringBuilder
    }
}

