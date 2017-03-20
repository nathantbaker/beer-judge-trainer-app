//
//  TrainerScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

//mimicks ScoresheetExpert class, but it's instantiated manually without needing API data
public class ScoresheetTrainer {
    // scores
    var aroma = 0.0
    var appearance = 0.0
    var flavor = 0.0
    var mouthfeel = 0.0
    var impression = 0.0
    
    // relationships
    var id = ""
    var beerId = ""
    var categoryId = ""
    
    // computed
    var total: Double { return aroma + appearance + flavor + mouthfeel + impression }
    var beer = ""
    var category = ""
}
