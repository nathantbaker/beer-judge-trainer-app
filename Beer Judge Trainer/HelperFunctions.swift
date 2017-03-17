//
//  HelperFunctions.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

class HelperFunctions {
    
    public func convertArrayOfDictionariesToArray(
        rawData:[[String: AnyObject]]) -> [String] {
    
        var arrayOfBreweries = [String]()
    
        for i in 0 ..< rawData.count {                 // iterate over brewery array
            for (key, value) in rawData[i] {           // iterate over each dictionary
                if key == "brewery_name" {          // filter to just key "brewery_name"
                    arrayOfBreweries.append(value as! String) // push value to array
                    }
                }
        }
    
        print(arrayOfBreweries)
        
        let alphabeticalArray = arrayOfBreweries.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    
        return alphabeticalArray
    
    
    }
}
