//
//  RateBeerController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

//create user scoresheet to store inputs
//var trainerScores = ScoresheetTrainer (
//    beer: userSelectedBeer,
//    brewery: userSelectedBrewery
//)

class RateBeerController: UIViewController  {
    
    func testStuff() {
        // print("current user scoresheet: \(trainerScores.beer_name)")
    }

    override func viewDidLoad() {
        let beerData = BeerDataFetcher.sharedData
        let firstRatedBeer = beerData.userSelectedBeer // constant
        
        self.title = "Rate \(beerData.userSelectedBeer)"
        // reset trainer scoresheet if it's a new beer
        if firstRatedBeer != beerData.userSelectedBeer {
        //    trainerScores = ScoresheetTrainer (
        //        beer: userSelectedBeer,
        //        brewery: userSelectedBrewery
        //    )
        }
        testStuff()
    }
    
}
