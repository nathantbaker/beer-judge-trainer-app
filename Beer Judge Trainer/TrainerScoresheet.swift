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
    
    public var score_aroma = 0.0
    public var score_appearance = 0.0
    public var score_flavor = 0.0
    public var score_mouthfeel = 0.0
    public var score_overall_impression = 0.0
    
    
    public var score_total: Double {
        return score_aroma + score_appearance + score_flavor + score_mouthfeel + score_overall_impression
    }
    
    public var full_name: String {
        return "\(brewery_name)'s \(beer_name)"
    }
    
    init (
        beer: String,
        brewery: String
//        aroma: Double,
//        appearance: Double,
//        flavor: Double,
//        mouthfeel: Double,
//        overall: Double
    ) {
        self.beer_name = beer
        self.brewery_name = brewery
//        self.score_aroma = aroma
//        self.score_appearance = appearance
//        self.score_flavor = flavor
//        self.score_mouthfeel = mouthfeel
//        self.score_overall_impression = overall
    }
}
