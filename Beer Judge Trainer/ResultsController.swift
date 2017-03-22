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
    let helperBot = HelperFunctions()
    let resultsBot = ScoresheetComparisonBot()
    let languageBot = DynamicLanguageBot()

    // view elements
    
        // beer info
        @IBOutlet weak var textBeerFullName: UILabel!
        @IBOutlet weak var textBeerCategory: UILabel!
        @IBOutlet weak var textAboutTheData: UILabel!
    
        // trainer info
        @IBOutlet weak var textTrainerReviewTitle: UILabel!
        
        // score totals
        @IBOutlet weak var scoreTotalTrainer: UILabel!
        @IBOutlet weak var scoreTotalExpert: UILabel!
        @IBOutlet weak var scoreTotalTrainerRange: UILabel!
        @IBOutlet weak var scoreTotalExpertRange: UILabel!
    
        // score categories
        @IBOutlet weak var scoreComparisonAroma: UILabel!
        @IBOutlet weak var scoreComparisonAppearance: UILabel!
        @IBOutlet weak var scoreComparisonFlavor: UILabel!
        @IBOutlet weak var scoreComparisonMouthfeel: UILabel!
        @IBOutlet weak var scoreComparisonImpression: UILabel!
    
        // descriptive text
        @IBOutlet weak var comparisonTotalString: UILabel!
    
        // ui elements
        @IBOutlet weak var backgroundColorBox: UILabel!
        @IBOutlet weak var resultsBox1: UITextView!
        @IBOutlet weak var resultsBox2: UITextView!
        
        // Rate Another Beer button
        @IBOutlet weak var RateAnotherBeer: UIButton!
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // gather expert scores
        resultsBot.averageExpertScoresheets()
        
        // gather scores comparison info
        resultsBot.averageExpertScoresheets()
        
        // add dynamic elements to view
        setTotals(); setTrainerReview(); setBeerInfo(); setScoreCategoryInfo()
        
        // stylin'
        styleElements()
    }
    
    func setTotals() {
    
        // set total for trainer
        scoreTotalTrainer.text = String(beerData.scoresheetTrainer.total)

        // set total range for trainer
        scoreTotalTrainerRange.text = languageBot.scoreTotalRange(score: beerData.scoresheetTrainer.total)

        // set total for expert
        scoreTotalExpert.text = String(beerData.scoresheetExpert.total)
        
        // set total range for expert
        scoreTotalExpertRange.text = languageBot.scoreTotalRange(score: beerData.scoresheetExpert.total)

        // set difference in score text
        resultsBot.getScoresheetDifference()
        let totalDifference = beerData.scoresheetComparison.total
        
        if totalDifference == 0.0 {
            comparisonTotalString.text = "Exact Match"
        } else {
            // strip negative sign
            let absoluteNum = (abs(totalDifference))
            // remove trailing zeros
            let formattedNumber = String(format: "%g", absoluteNum)
            comparisonTotalString.text = "\(formattedNumber) point difference"
        }
    }
    
    func setTrainerReview() {
        
        // set trainer review title
        let testNumber = beerData.scoresheetComparison.total
        textTrainerReviewTitle.text = languageBot.trainerReviewTitle(pointDiff: testNumber)
        
        // set background color
        let newColor = languageBot.trainerResultsBackgroundColor(pointDiff: testNumber)
        backgroundColorBox.backgroundColor = newColor
    }
    
    func setBeerInfo() {
        
        let beer = beerData.scoresheetTrainer.beer
        let brewery = beerData.scoresheetTrainer.brewery
        let category = beerData.scoresheetTrainer.category
        
        // set full beer name header
        textBeerFullName.text = "\(brewery)'s \(beer)"

        // set beer category header
        textBeerCategory.text = category
    }
    
    func setScoreCategoryInfo() {
        
        // capture data
        let aroma = beerData.scoresheetComparison.aroma
        let appearance = beerData.scoresheetComparison.appearance
        let flavor = beerData.scoresheetComparison.flavor
        let mouthfeel = beerData.scoresheetComparison.mouthfeel
        let impression = beerData.scoresheetComparison.impression

        // function to format and set numbers
        func setCategoryNumber(number: Double, uiElement: UILabel) {
            
            if number < 0 {
                
                // red, one decimal place, add a space after the minus sign
                uiElement.textColor = UIColor(red:0.75, green:0.27, blue:0.00, alpha:1.0) // red
                let string = String(format: "%g", number)
                uiElement.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
                
            } else if number > 0 {
                
                // already green, one decimal place, space after +
                uiElement.text = "+ \(String(format: "%g", number))"
                
            } else {
                
                // set to grey, default is 0.0 already
                uiElement.textColor = UIColor.gray
            }
        }
        
        // set numbers
        setCategoryNumber(number: aroma, uiElement: scoreComparisonAroma)
        setCategoryNumber(number: appearance, uiElement: scoreComparisonAppearance)
        setCategoryNumber(number: flavor, uiElement: scoreComparisonFlavor)
        setCategoryNumber(number: mouthfeel, uiElement: scoreComparisonMouthfeel)
        setCategoryNumber(number: impression, uiElement: scoreComparisonImpression)
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

