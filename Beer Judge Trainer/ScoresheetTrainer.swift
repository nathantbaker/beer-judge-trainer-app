////
////  TrainerScoresheet.swift
////  Beer Judge Trainer
////
////  Created by Nate on 3/14/17.
////  Copyright © 2017 Nathan T. Baker. All rights reserved.
////
//
//import Foundation
//
//// inherit properties from Expert Scoresheet but accept user inputs
//public class ScoresheetTrainer: ScoresheetExpert {
//    
//    // computed since only the api, and not the user has this info
//    override var id: String {
//        get { return "" }
//        set { }
//    }
//    
//    override var categoryId: String {
//        get { return "" }
//        set { }
//    }
//       
//    // instansiate the class with user input rather than from api data
//    init(
//        score_aroma: Double,
//        score_appearance: Double,
//        score_flavor: Double,
//        score_mouthfeel: Double,
//        score_overall_impression: Double,
//        idBeers: String
//    ) {
//        //scores
//        aroma = score_aroma
//        appearance = score_appearance
//        flavor = score_flavor
//        mouthfeel = score_mouthfeel
//        impression = score_overall_impression
//        
//        // relationships
//        beerId = idBeers
//    }
//}
