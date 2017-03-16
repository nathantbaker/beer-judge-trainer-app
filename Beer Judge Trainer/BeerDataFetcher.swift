//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// The BeerDataFetcher gathers data from the API and stores it locally
public class BeerDataFetcher {
    
    // properies on the class where beer resources are stored
    var beer = [[String: AnyObject]]()
    var breweries = [[String: AnyObject]]()
    var scoresheets = [[String: AnyObject]]()
    var categories = [[String: AnyObject]]()
    
    // fetch all resources needed from the API
    func FetchAllBeerResources() {
        self.GetResource(endpoint: "beers")       { data in self.beer = data }
        self.GetResource(endpoint: "breweries")   { data in self.breweries = data }
        self.GetResource(endpoint: "scoresheets") { data in self.scoresheets = data }
        self.GetResource(endpoint: "categories")  { data in self.categories = data }
    }
    
    // function to get a resource from the API
    func GetResource(endpoint: String, completionHandler: @escaping (_ responseData: [[String: AnyObject]]) -> ()) {
        
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
            
            // parse results into dictionary
            let results = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let resultString = results as! String
            let dataDictionary = self.convertStringToDictionary(text: resultString)
            let numberOfKeys = dataDictionary?.count
            print("The \(endpoint) dictionary has \(numberOfKeys!) items")
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
        
        }
        task.resume()
    }
    
    // function to convert JSON strings to dictionaries
    func convertStringToDictionary(text: String) -> [[String: AnyObject]]? {
        
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                // return a dictionary of dictionaries
                // with strings as keys and whatevs as values
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}

