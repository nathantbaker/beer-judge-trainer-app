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
    
    init?(data: [String: AnyObject]) {
        guard let url = data["url"] as? String, let category_name = data["category_name"] as? String else {
            return nil
        }
        
        id = url
        name = category_name
    }
}
