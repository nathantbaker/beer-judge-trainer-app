//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// The BeerDataFetcher gathers data from http://api.cancanawards.com/
public class BeerDataFetcher {
    
    // singleton to instanciate a single, shared class so all controllers have access to the same data
    static let sharedData: BeerDataFetcher = BeerDataFetcher()

    // class properies where beer objects are stored
    var beers = [Beer]()
    var breweries = [Brewery]()
    var scoresheets = [ScoresheetExpert]()
    var categories = [BeerCategory]()
    
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
            print(" • The \(endpoint) dictionary has \(numberOfKeys!) items")
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
        
        }
        task.resume()
    }
    
    // get scoresheet and categories data.
    // beers and breweries initially fetched in home view controller
    // fetch all resources needed from the API, then save it locally
    func FetchAllBeerResources() {
        getResource(endpoint: "categories") { data in
            
            print("raw data...... \(data)")
            
            var categories = [BeerCategory]()
            
            for item in data {
                
//            item example:
//                [
//                    "url": http://api.cancanawards.com/categories/1/,
//                    "category_name": American-Style Pale Ale
//                ]
                
                if let category = BeerCategory(data: item) {
                    categories.append(category)
                }
            }
            self.categories = categories
            let testCategories = BeerDataFetcher.sharedData.categories
            print("LOCAL BEER CATEGORIES")
            print(testCategories[0].name)
            print(testCategories[1].name)
            print(testCategories[2].name)
        }
    }
    
    
    
//    
//    func fetchAllBeerResources() {
//        getResource(endpoint: "scoresheets") {
//            // using weak self to reduce likelihood of memory leaks
//            [weak self](data) in self?.scoresheets = data
//        }
//        getResource(endpoint: "categories") {
//            [weak self](data) in self?.categories = data
//        }
//    }
}
