//
//  TrainerScoresheet.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//
//  API endpoint: http://api.cancanawards.com/scoresheets/


// This is the class that glues together the other classes.
//        [
//              "score_overall_impression": 5.0,
//              "idBeers": http://api.cancanawards.com/beers/39/,
//              "score_mouthfeel": 3.0,
//              "idCategories": http://api.cancanawards.com/categories/1/,
//              "score_total": 26.5,
//              "score_aroma": 7.0,
//              "score_appearance": 1.5,
//              "url": http://api.cancanawards.com/scoresheets/114/,
//              "score_flavor": 10.0
//        ]

import Foundation

public class Scoresheet {
    
    // scores
    var aroma = ""
    var appearance = ""
    var flavor = ""
    var mouthfeel = ""
    var impression = ""
    var total = ""
    
    // relationships
    var id = ""
    var beerId = ""
    var categoryId = ""
    
    // computed
//    var total: Double { return aroma + appearance + flavor + mouthfeel + impression }
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
