//
//  HelperFunctions.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

class HelperFunctions {
    
    // function to convert array of dictionarys to one array based on a key 
    public func convertArrayOfDictionariesToArray( rawData:[[String: AnyObject]], filterKey: String ) -> [String] {
    
        var arrayOfBreweries = [String]()
    
        for i in 0 ..< rawData.count {                        // iterate over brewery array
            for (key, value) in rawData[i] {                  // iterate over each dictionary
                if key == filterKey {                         // filter to just key like "brewery_name" etc
                    arrayOfBreweries.append(value as! String) // push value to array
                    }
                }
        }
    
        let alphabeticalArray = arrayOfBreweries.sorted { // alphabetize the results
            $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending
        }
    
        return alphabeticalArray
    }

    // function to convert JSON strings to array of dictionaries
    public func convertStringToDictionaryOfDictionaries(text: String) -> [[String: AnyObject]]? {
        
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
    
    // function to return an array of values which are tied to another value (beers of a brewery, etc)
    public func returnArrayBasedOnFiltering(dataSet: [[String:AnyObject]], filter: String) -> [String] {
        print("filter: \(filter)")
        print("data set: \(dataSet)")
        for brewery in dataSet {                    // iterate over brewery array
            print(brewery)
//            for (key, value) in brewery[i] {                  // iterate over each dictionary
//                if key == filterKey {                         // filter to just key like "brewery_name" etc
//                    arrayOfBreweries.append(value as! String) // push value to array
//                }
//            }
        }

        
        
        
        // find id for provided brewery
        
        // find beers that have the same brewery id
        
        // format to an array
        
        return ["Best Beer Eva", "Second Best"]
    }
        
    
}
