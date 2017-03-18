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
    
    // setters
    func setBreweryData (breweryData: [[String: AnyObject]]) {
        self.breweries = breweryData
    }
    func setBeerData (beerData: [[String: AnyObject]]) {
        self.beers = beerData
    }
    
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
            let dataDictionary = HelperFunctions().convertStringToDictionaryOfDictionaries(text: resultString)
            let numberOfKeys = dataDictionary?.count
            print("  • The \(endpoint) dictionary has \(numberOfKeys!) items")
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
        
        }
        task.resume()
    }
    
    // get scoresheet and categories data.
    // beers and breweries initially fetched in home view controller
    func fetchAllBeerResources() {
        getResource(endpoint: "scoresheets") {
            // using weak self to reduce likelihood of memory leaks
            [weak self](data) in self?.scoresheets = data
        }
        getResource(endpoint: "categories") {
            [weak self](data) in self?.categories = data
        }
    }
}
