//
//  Beer.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/19/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/beers/

import Foundation

class Beer {

    var id = ""
    var name = ""
    var breweryId = ""
    
    // computed values
    let beerData = BeerDataFetcher.sharedData
    
    // return the brewery object tied to a beer
    var brewery: Brewery {
        var target: Brewery = beerData.breweries[0]
        for brewery in beerData.breweries {
            if brewery.id == self.breweryId {
                target = brewery; break
            }
        }
        return target
    }
    
    // return the category name tied to a beer
    var category: String {
        
        var target = ""
        
        for scoresheet in beerData.scoresheets {
        
            if self.id == scoresheet.beerId {
            
                let targetCategoryId = scoresheet.categoryId
                for categoryObject in beerData.categories {
                
                    if targetCategoryId == categoryObject.id {
                        target = categoryObject.name; break
                    }
                }
            }
        }
        return target
    }
    
    init?(data: [String: AnyObject]) {
        guard let url = data["url"] as? String, let beer_name = data["beer_name"] as? String, let idBreweries = data["idBreweries"] as? String else {
            return nil
        }
        
        id = url
        name = beer_name
        breweryId = idBreweries
    }
}
