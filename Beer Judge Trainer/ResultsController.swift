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
    let resultsBot = ScoresheetComparisonBot()

    // view elements
    @IBOutlet weak var RateAnotherBeer: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("results view loaded!")
        print("")
        print("category scores")
        print(beerData.scoresheetTrainer.aroma)
        print(beerData.scoresheetTrainer.appearance)
        print(beerData.scoresheetTrainer.flavor)
        print(beerData.scoresheetTrainer.mouthfeel)
        print(beerData.scoresheetTrainer.impression)
        print("")
        print("total for scoresheet")
        print(beerData.scoresheetTrainer.total)
        print("")
        print("beer data for scoresheet")
        print(beerData.scoresheetTrainer.beer)
        print(beerData.scoresheetTrainer.brewery)
        print(beerData.scoresheetTrainer.category)
    
        resultsBot.averageExpertScoresheets()
        print("")
        print("expert scoresheet averages")
        print(beerData.scoresheetExpert.aroma)
        print(beerData.scoresheetExpert.appearance)
        print(beerData.scoresheetExpert.flavor)
        print(beerData.scoresheetExpert.mouthfeel)
        print(beerData.scoresheetExpert.impression)
        print(beerData.scoresheetExpert.total)
        
        
        
        // round button corners
        RateAnotherBeer.layer.cornerRadius = 0.02 * RateAnotherBeer.bounds.size.width
        RateAnotherBeer.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

