//
//  TrainerScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// class that gathers and stores user inputs for a beer
public class TrainerScoreSheet {
    
    public var beer_name = ""
    public var brewery_name = ""
    
    public var full_name: String {
        return "\(brewery_name)'s \(beer_name)"
    }
    
    init(beer: String, brewery: String) {
        self.beer_name = beer
        self.brewery_name = brewery
    }
}
