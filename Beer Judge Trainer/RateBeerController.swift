//
//  RateBeerController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

//create user scoresheet to store inputs
let userInputs = TrainerScoreSheet(
    beer: userSelectedBeer,
    brewery: userSelectedBrewery
)

class RateBeerController: UIViewController  {
    
    override func viewDidLoad() {
        self.title = "Rate \(userInputs.beer_name)"
    
    }
}
