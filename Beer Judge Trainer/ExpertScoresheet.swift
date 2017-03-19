//
//  ExpertScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/18/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// class that gathers and stores user inputs for a beer
public class ExpertScoreSheet {
    
    public var beer_name = ""
    public var brewery_name = ""
    
    // testing out computed values. can just pull expert scoresheet based on what's instanciated
    public var score_aroma: Double {
        return returnValue(beer_name: beer_name)
    }
 
    public var score_appearance: Double {
        return returnValue(beer_name: beer_name)
    }

    public var score_flavor: Double {
        return returnValue(beer_name: beer_name)
    }

    public var score_mouthfeel: Double {
        return returnValue(beer_name: beer_name)
    }

    public var score_overall_impression: Double {
        return returnValue(beer_name: beer_name)
    }

    public var score_total: Double {
        return returnValue(beer_name: beer_name)
    }

    
    public var full_name: String {
        return "\(brewery_name)'s \(beer_name)"
    }
    
    init(beer: String, brewery: String) {
        self.beer_name = beer
        self.brewery_name = brewery
    }
    
    func returnValue(beer_name: String) -> Double {
        return 0.0
    }
}
