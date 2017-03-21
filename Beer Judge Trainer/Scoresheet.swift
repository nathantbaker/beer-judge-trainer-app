//
//  Scoresheet.swift
//  BrewJudge
//
//  Created by Nate on 3/21/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

// Base for scoresheet object

public class Scoresheet {
    
    // scores
    var aroma = 0.0
    var appearance = 0.0
    var flavor = 0.0
    var mouthfeel = 0.0
    var impression = 0.0
    var total = 0.0
    
    // relationships
    var id = ""
    var beerId = ""
    var categoryId = ""
    
    // beer data
    var beer = ""
    var brewery = ""
    var category = ""
}
