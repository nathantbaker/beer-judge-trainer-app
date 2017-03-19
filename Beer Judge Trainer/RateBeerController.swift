//
//  RateBeerController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

//create user scoresheet to store inputs
var trainerScores = TrainerScoreSheet (
    beer: userSelectedBeer,
    brewery: userSelectedBrewery
)

class RateBeerController: UIViewController  {
    
    let firstRatedBeer = userSelectedBeer // constant
    
    func testStuff() {
        print("current user scoresheet: \(trainerScores.beer_name)")
    }

    override func viewDidLoad() {
        // set view title to beer being rated
        self.title = "Rate \(userSelectedBeer)"
        // reset trainer scoresheet if it's a new beer
        if firstRatedBeer != userSelectedBeer {
            trainerScores = TrainerScoreSheet (
                beer: userSelectedBeer,
                brewery: userSelectedBrewery
            )
        }
        testStuff()
    }
    
}
