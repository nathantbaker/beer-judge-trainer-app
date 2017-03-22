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
    
        // beer info
        @IBOutlet weak var textBeerFullName: UILabel!
        @IBOutlet weak var textBeerCategory: UILabel!
        @IBOutlet weak var textAboutTheData: UILabel!
        
        // trainer info
        @IBOutlet weak var textTrainerReview: UILabel!
        
        // score numbers
        @IBOutlet weak var scoreTotalTrainer: UILabel!
        @IBOutlet weak var scoreTotalExpert: UILabel!
        @IBOutlet weak var scoreComparisonAroma: UILabel!
        @IBOutlet weak var scoreComparisonAppearance: UILabel!
        
        // descriptive text
        @IBOutlet weak var comparisonTotalString: UILabel!
        @IBOutlet weak var comparisonAromaString: UILabel!
        
        // ui elements
        @IBOutlet weak var backgroundColorBox: UILabel!
        @IBOutlet weak var resultsBox1: UITextView!
        @IBOutlet weak var resultsBox2: UITextView!
        
        // Rate Another Beer button
        @IBOutlet weak var RateAnotherBeer: UIButton!
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set feedback text to view title
        self.title = "👍 Nailed it!"
        
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
        
        styleElements()
        

        
    }
    
    func styleElements() {
        // round button corners
        RateAnotherBeer.layer.cornerRadius = 5
        RateAnotherBeer.clipsToBounds = true
        
        // round result boxes
        resultsBox1.layer.cornerRadius = 10
        resultsBox1.clipsToBounds = true
        resultsBox2.layer.cornerRadius = 10
        resultsBox2.clipsToBounds = true
        
        // faint border around result boxes
        let lightGrey : UIColor = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.0)
        resultsBox1.layer.borderColor = lightGrey.cgColor
        resultsBox1.layer.borderWidth = 0.5
        resultsBox2.layer.borderColor = lightGrey.cgColor
        resultsBox2.layer.borderWidth = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

