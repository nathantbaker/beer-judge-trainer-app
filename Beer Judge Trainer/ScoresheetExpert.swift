//
//  TrainerScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/scoresheets/

import Foundation

// This is the class that glues together the other classes.
public class ScoresheetExpert {
    
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
    
    // by default instansiate the class with data from http://api.cancanawards.com/scoresheets/
    init?(data: [String: AnyObject]) {

        guard let url = data["url"] as? String,
        let score_aroma = data["score_aroma"] as? Double,
        let score_appearance = data["score_appearance"] as? Double,
        let score_flavor = data["score_flavor"] as? Double,
        let score_mouthfeel = data["score_mouthfeel"] as? Double,
        let score_overall_impression = data["score_overall_impression"] as? Double,
        let idBeers = data["idBeers"] as? String,
        let idCategories = data["idCategories"] as? String

        else {
            return nil
        }
        
        //scores
        aroma = score_aroma
        appearance = score_appearance
        flavor = score_flavor
        mouthfeel = score_mouthfeel
        impression = score_overall_impression
        
        // relationships
        id = url
        beerId = idBeers
        categoryId = idCategories
    }
}
