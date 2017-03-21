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
    
    // comparison numbers
    @IBOutlet weak var comparisonTotalString: UILabel!
    
    // ui elements
    @IBOutlet weak var backgroundColorBox: UILabel!
    @IBOutlet weak var resultsBox1: UITextView!
    @IBOutlet weak var resultsBox2: UITextView!
    
    // Rate Another Beer button
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
        
        resultsBot.getScoresheetDifference()
        print("")
        print("expert scoresheet differences")
        print(beerData.scoresheetComparison.aroma)
        print(beerData.scoresheetComparison.appearance)
        print(beerData.scoresheetComparison.flavor)
        print(beerData.scoresheetComparison.mouthfeel)
        print(beerData.scoresheetComparison.impression)
        print(beerData.scoresheetComparison.total)
        
        
        // round button corners
        RateAnotherBeer.layer.cornerRadius = 0.02 * RateAnotherBeer.bounds.size.width
        RateAnotherBeer.clipsToBounds = true
        
        // round results boxes
        resultsBox1.layer.cornerRadius = 0.09 * resultsBox1.bounds.size.width
        resultsBox1.clipsToBounds = true
        
        resultsBox2.layer.cornerRadius = 0.09 * resultsBox2.bounds.size.width
        resultsBox2.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

