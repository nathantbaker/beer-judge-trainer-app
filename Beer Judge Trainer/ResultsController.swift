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
        
        testing()
        

        
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
        
        let red: UIColor = UIColor(red:0.75, green:0.27, blue:0.00, alpha:1.0)
        
        if appearance < 0 { scoreComparisonAppearance.textColor = red }
        if flavor < 0 { scoreComparisonFlavor.textColor = red }
        if mouthfeel < 0 { scoreComparisonMouthfeel.textColor = red }
        if impression < 0 { scoreComparisonImpression.textColor = red }
        
        //  - default is green. set to red if negative
        //  - add "+ " to positive numbers
        //  - format number to one decimal
        
        //aroma
        if aroma < 0 {
            scoreComparisonAroma.textColor = red
            let string = String(format: "%g", aroma)
            scoreComparisonAroma.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
        } else if aroma > 0 {
            scoreComparisonAroma.text = "+ \(String(format: "%g", aroma))"
        } else {
            // default already 0.0
            scoreComparisonAroma.textColor = UIColor.gray
        }
        
        // appearance
        if appearance < 0 {
            scoreComparisonAppearance.textColor = red
            let string = String(format: "%g", appearance)
            scoreComparisonAppearance.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
        } else if appearance > 0 {
            scoreComparisonAppearance.text = "+ \(String(format: "%g", appearance))"
        } else {
            // default already 0.0
            scoreComparisonAppearance.textColor = UIColor.gray
        }
        
        // flavor
        if flavor < 0 {
            scoreComparisonFlavor.textColor = red
            let string = String(format: "%g", flavor)
            scoreComparisonFlavor.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
        } else if flavor > 0 {
            scoreComparisonFlavor.text = "+ \(String(format: "%g", flavor))"
        } else {
            // default already 0.0
            scoreComparisonFlavor.textColor = UIColor.gray
        }
        
        // mouthfeel
        if mouthfeel < 0 {
            scoreComparisonMouthfeel.textColor = red
            let string = String(format: "%g", mouthfeel)
            scoreComparisonMouthfeel.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
        } else if mouthfeel > 0 {
            scoreComparisonMouthfeel.text = "+ \(String(format: "%g", mouthfeel))"
        } else {
            // default already 0.0
            scoreComparisonMouthfeel.textColor = UIColor.gray
        }
        
        // overall impression
        if impression < 0 {
            scoreComparisonImpression.textColor = red
            let string = String(format: "%g", impression)
            scoreComparisonImpression.text = string.replacingOccurrences(of: "-", with: "- ", options: .literal, range: nil)
        } else if impression > 0 {
            scoreComparisonImpression.text = "+ \(String(format: "%g", impression))"
        } else {
            // default already 0.0
            scoreComparisonImpression.textColor = UIColor.gray
        }        
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
    
    func testing() {
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
    }
    
    
}

