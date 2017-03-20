//
//  HelperFunctions.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

class HelperFunctions {
    
    let beerData = BeerDataFetcher.sharedData
    
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
    
    // function to return brewery object from brewery name
    public func getBreweryObjectFromName(brewery: String) -> Brewery {
        var target = beerData.breweries[0] // set target to first brewery
        if let indexNumber = beerData.breweries.index(where: { $0.name == brewery}) {
            target = beerData.breweries[indexNumber] // change value of target
        }
        return target
    }
    
    // function to return beer object from beer name
    public func getBeerObjectFromName(beer: String) -> Beer {
        var target = beerData.beers[0] // set target to first brewery
        if let indexNumber = beerData.beers.index(where: { $0.name == beer}) {
            target = beerData.beers[indexNumber] // change value of target
        }
        return target
    }
    
    // function to return an array of the brewery associated with a beer
    public func returnBreweryOfBeer(beerData: [[String:AnyObject]], breweryData: [[String:AnyObject]], filterWord: String) -> [String] {
        
        // placeholders
        var targetBreweryId = String()
        var ArrayOfBrewery = [String]()
        
        // target dictionary with the id
        for beer in beerData {
            for (_, value) in beer {                 // loop over brewery array
                if value as! String == filterWord {     // find dictionaries with a brewery_name etc of the filter word
                    targetBreweryId = beer["idBreweries"] as! String   // capture brewery id for the brewery
                    print("targetBreweryId: \(targetBreweryId)")
                }
            }
        }
        
        // find brewery dictionaries with that id
        for brewery in breweryData {
            for (_, value) in brewery {                 // loop over beer array
                if value as! String == targetBreweryId {     // find dictionaries with a brewery_name etc of the filter word
                    ArrayOfBrewery.append(brewery["brewery_name"] as! String)
                }
            }
        }
        
        return ArrayOfBrewery
    }
    
    // function to return the beer category associated with a beer
    // ...

    
    
}
