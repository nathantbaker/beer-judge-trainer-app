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

    @IBOutlet weak var topInfoText: UILabel!
    
    override func viewDidLoad() {
        let beerData = BeerDataFetcher.sharedData
        let helperBot = HelperFunctions()
        let firstRatedBeer = beerData.userSelectedBeer // constant
        
        self.title = "Rate \(beerData.userSelectedBeer)"
        let beerObject = helperBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
        if beerObject.category != "" { // fixes bug in which you error then go to results screen
            topInfoText.text = "Assign up to 50 points for this \(beerObject.category)."
        }
        
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
