//
//  BeerCategory.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/19/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/categories/

import Foundation

class BeerCategory {
    var id = ""
    var name = ""
    
    // return number of scoresheets in a category
    var scoresheets: Int {
        
        let beerData = BeerDataFetcher.sharedData
        var arrayOfScoresheets = [ScoresheetExpert]()

        // look at all scoresheets
        for scoresheet in beerData.scoresheets {
            // keep scoresheets that have current category id
            if self.id == scoresheet.categoryId {
                arrayOfScoresheets.append(scoresheet)
            }
        }
        
        return arrayOfScoresheets.count
    }

    
    init?(data: [String: AnyObject]) {
        guard let url = data["url"] as? String, let category_name = data["category_name"] as? String else {
            return nil
        }
        
        id = url
        name = category_name
    }
}
