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
    
    // function to return category of currently selected beer
    public func getCategoryFromSelectedBeer() -> String {
        let beerObject = self.getBeerObjectFromName(beer: beerData.userSelectedBeer)
        return beerObject.category
    }
}
