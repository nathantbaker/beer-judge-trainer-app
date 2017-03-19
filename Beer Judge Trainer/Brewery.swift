//
//  Breweries.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/breweries/

import Foundation

class Brewery {
    var id = ""
    var name = ""
    
    // computed
    // ...
    
    init?(data: [String: AnyObject]) {
        guard let url = data["url"] as? String, let brewery_name = data["brewery_name"] as? String else {
            return nil
        }
        
        id = url
        name = brewery_name
    }
}
