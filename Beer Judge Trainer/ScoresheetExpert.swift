//
//  TrainerScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/scoresheets/

import Foundation

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
        let score_aroma = data["score_aroma"] as? String,
        let score_appearance = data["score_appearance"] as? String,
        let score_flavor = data["score_flavor"] as? String,
        let score_mouthfeel = data["score_mouthfeel"] as? String,
        let score_overall_impression = data["score_overall_impression"] as? String,
        let idBeers = data["idBeers"] as? String,
        let idCategories = data["idCategories"] as? String else {
            return nil
        }
        
        //scores
        aroma = Double(score_aroma)!
        appearance = Double(score_appearance)!
        flavor = Double(score_flavor)!
        mouthfeel = Double(score_mouthfeel)!
        impression = Double(score_overall_impression)!
        
        // relationships
        id = url
        beerId = idBeers
        categoryId = idCategories
    }
}
