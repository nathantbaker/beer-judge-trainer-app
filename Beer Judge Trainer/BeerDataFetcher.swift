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
            print(" • The \(endpoint) table has \(numberOfKeys!) items")
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
        
        }
        task.resume()
    }
    

    // pull down all data from api
    func FetchAllBeerResources(completionHandler: @escaping (_ responseData: String) -> ()) {
        
        let numberOfResourcesToFetch = 2
        var fetchCOunter = 0

        // send mesage DONE after all data is parsed
        func checkIfAllDataFetched() {
            fetchCOunter += 1
            if fetchCOunter == numberOfResourcesToFetch {
                completionHandler("✓ done")
            } else {
                print("waiting to download more data")
            }
        }
        
        // categories: parse into objects
        getResource(endpoint: "categories") { arrayOfDictionaries in
            var tempCategories = [BeerCategory]()
            for dictionary in arrayOfDictionaries {
                print(dictionary)
                // instantiate new object with a dictionary
                // item example: ["url": "http...", "category_name": "IPA"]
                if let category = BeerCategory(data: dictionary) {
                    tempCategories.append(category)
                }
            }
            self.categories = tempCategories // push array to local property
            checkIfAllDataFetched()
        }
        
        // scoresheets: parse into objects
        getResource(endpoint: "scoresheets") { arrayOfDictionaries in
            var tempScoresheets = [ScoresheetExpert]()
            for dictionary in arrayOfDictionaries {
                if let scoresheet = ScoresheetExpert(data: dictionary) {
                    tempScoresheets.append(scoresheet)
                }
            }
            self.scoresheets = tempScoresheets
            checkIfAllDataFetched()
            
        }
            

    }

}
