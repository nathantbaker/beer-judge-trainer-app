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
    
    
    // element reference outlets
    
    // informative text
    @IBOutlet weak var topInfoText: UILabel!
    @IBOutlet weak var scoreRangeTitle: UILabel!
    @IBOutlet weak var scoreRangeDescription: UILabel!
    // score input
    
    // score outputs
    @IBOutlet weak var scoreOutputAroma: UILabel!
    @IBOutlet weak var scoreOutputAppearance: UILabel!
    @IBOutlet weak var scoreOutputFlavor: UILabel!
    @IBOutlet weak var scoreOutputMouthfeel: UILabel!
    @IBOutlet weak var scoreOutputImpression: UILabel!
    @IBOutlet weak var scoreOutputTotal: UILabel!
    
    @IBAction func scoreInputAroma(_ sender: Any) {
    }

    @IBAction func scoreInputAppearance(_ sender: Any) {
    }
    
    
    @IBAction func scoreInputFlavor(_ sender: Any) {
    }
    
    @IBAction func scoreInputMouthfeel(_ sender: Any) {
    }
    
    
    @IBAction func scoreInputImpression(_ sender: Any) {
    }
    
    func testStuff() {
        // print("current user scoresheet: \(trainerScores.beer_name)")
    }
    

    
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
