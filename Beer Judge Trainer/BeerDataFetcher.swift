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
    
    // singleton to instanciate a single, shared class
    // so all classes have access to the same data
    static let sharedData: BeerDataFetcher = BeerDataFetcher()

    // class properies on singleton
    
        // beer data from api
        var allDataFetched = false
        var beers = [Beer]()
        var breweries = [Brewery]()
        var scoresheets = [ScoresheetExpert]()
        var categories = [BeerCategory]()
        // user inputs
        var userSelectedBrewery = "none"
        var userSelectedBeer = "none"
        // scoresheets
        var scoresheetTrainer = Scoresheet()
        var scoresheetExpert = Scoresheet()
        var scoresheetComparison = Scoresheet()
    
    // pull down all data from api
    func FetchAllBeerResources(completionHandler: @escaping (_ responseData: String) -> ()) {
        
        let numberOfResourcesToFetch = 4
        var fetchCounter = 0

        // send mesage DONE after all data is parsed
        func checkIfAllDataFetched() {
            fetchCounter += 1
            if fetchCounter == numberOfResourcesToFetch {
                completionHandler("✔ done")
            }
        }
        
        // categories: parse into objects
        getResource(endpoint: "categories") { arrayOfDictionaries in
            var tempCategories = [BeerCategory]()
            for dictionary in arrayOfDictionaries {
                // instantiate new object with a dictionary
                // item example: ["url": "http...", "category_name": "IPA"]
                if let category = BeerCategory(data: dictionary) { tempCategories.append(category) }
            }
            // push array to local property
            self.categories = tempCategories
            checkIfAllDataFetched()
        }
        
        // scoresheets: parse into objects
        getResource(endpoint: "scoresheets") { arrayOfDictionaries in
            var tempScoresheets = [ScoresheetExpert]()
            for dictionary in arrayOfDictionaries {
                if let scoresheet = ScoresheetExpert(data: dictionary) { tempScoresheets.append(scoresheet) }
            }
            self.scoresheets = tempScoresheets
            checkIfAllDataFetched()
        }
        
        // beers: parse into objects
        getResource(endpoint: "beers") { arrayOfDictionaries in
            var tempBeers = [Beer]()
            for dictionary in arrayOfDictionaries {
                if let beer = Beer(data: dictionary) { tempBeers.append(beer) }
            }
            self.beers = tempBeers
            checkIfAllDataFetched()
        }
        
        // breweries: parse into objects
        getResource(endpoint: "breweries") { arrayOfDictionaries in
            var tempBreweries = [Brewery]()
            for dictionary in arrayOfDictionaries {
                if let brewery = Brewery(data: dictionary) { tempBreweries.append(brewery) }
            }
            self.breweries = tempBreweries
            checkIfAllDataFetched()
        }
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
            print(" • The \(endpoint) table has \(numberOfKeys!) items")
            
            // return data
            completionHandler(dataDictionary! as [[String: AnyObject]])
            
        }
        task.resume()
    }
}
