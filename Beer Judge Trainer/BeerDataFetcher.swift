//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// boolean to track when all resources are fetched
var allResourcesFetched = false
var resourcesFetchedCounter = 0

// The BeerDataFetcher gathers data from the API and stores it locally
public class BeerDataFetcher {
    
    // properies on the class where beer resources are stored
    var beers = [[String: AnyObject]]()
    var breweries = [[String: AnyObject]]()
    var scoresheets = [[String: AnyObject]]()
    var categories = [[String: AnyObject]]()
    
    // function to get a resource from the API
    func getResource(endpoint: String, completionHandler: @escaping (_ responseData: [[String: AnyObject]]) -> ()) {
        
        //  build url
        let myUrl = NSURL(string: "http://api.cancanawards.com/\(endpoint)/")
        
        // build request
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // error handling
            if let error = error {
                print("error=\(error)")
                return
            }
            
            // parse results into dictionary
            let results = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let resultString = results as! String
            let dataDictionary = self.convertStringToDictionary(text: resultString)
            let numberOfKeys = dataDictionary?.count
            print("  • The \(endpoint) dictionary has \(numberOfKeys!) items")
            
            // track when all resources are fetched
            resourcesFetchedCounter += 1
            if resourcesFetchedCounter == 4 {
                allResourcesFetched = true
                print("✓ All resources fetched")
                print("")
            }
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
        
        }
        task.resume()
    }
    
    // fetch all resources needed from the API, then store them locally
    func fetchAllBeerResources() {
        getResource(endpoint: "breweries")   { [weak self](data) in self?.breweries = data }
        getResource(endpoint: "beers")       { [weak self](data) in self?.beers = data }
        getResource(endpoint: "scoresheets") { [weak self](data) in self?.scoresheets = data }
        getResource(endpoint: "categories")  { [weak self](data) in self?.categories = data }
                                             // using weak self to reduce likelihood of memory leaks
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

