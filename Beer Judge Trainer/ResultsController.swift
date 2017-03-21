//
//  ResultsController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    
    let beerData = BeerDataFetcher.sharedData

    // view elements
    @IBOutlet weak var RateAnotherBeer: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("results view loaded!")
        print("")
        print("category scores")
        print(beerData.userScoresheet.aroma)
        print(beerData.userScoresheet.appearance)
        print(beerData.userScoresheet.flavor)
        print(beerData.userScoresheet.mouthfeel)
        print(beerData.userScoresheet.impression)
        print("")
        print("total for scoresheet")
        print(beerData.userScoresheet.total)
        print("")
        print("beer data for scoresheet")
        print(beerData.userScoresheet.beer)
        print(beerData.userScoresheet.brewery)
        print(beerData.userScoresheet.category)
        
        
        // round button corners
        RateAnotherBeer.layer.cornerRadius = 0.02 * RateAnotherBeer.bounds.size.width
        RateAnotherBeer.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

