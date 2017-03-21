//
//  RateBeerController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class RateBeerController: UIViewController  {
    
    let beerData = BeerDataFetcher.sharedData
    let helperBot = HelperFunctions()
    
    // ui elements
    
    // informative text
    @IBOutlet weak var topInfoText: UILabel!
    @IBOutlet weak var scoreRangeTitle: UILabel!
    @IBOutlet weak var scoreRangeDescription: UILabel!
    @IBOutlet weak var totalScoreBackgroundColor: UILabel!
    
    // slider elements
    @IBOutlet weak var sliderAroma: UISlider!
    @IBOutlet weak var sliderAppearance: UISlider!
    @IBOutlet weak var sliderFlavor: UISlider!
    @IBOutlet weak var sliderMouthfeel: UISlider!
    @IBOutlet weak var sliderImpression: UISlider!
    
    // score outputs
    @IBOutlet weak var scoreOutputAroma: UILabel!
    @IBOutlet weak var scoreOutputAppearance: UILabel!
    @IBOutlet weak var scoreOutputFlavor: UILabel!
    @IBOutlet weak var scoreOutputMouthfeel: UILabel!
    @IBOutlet weak var scoreOutputImpression: UILabel!
    @IBOutlet weak var scoreOutputTotal: UILabel!
    @IBOutlet weak var scoreYourScoreHeader: UILabel!
    
    //compare expert scores button
    @IBOutlet weak var compareExpertScoresButton: UIButton!
    
    // load/reload logic
    override func viewDidLoad() {

        // set beer title to the view
        self.title = "Rate \(beerData.userSelectedBeer)"
        
        // reset beer category info if view is navigated back to
        let category = helperBot.getCategoryFromSelectedBeer()
        if category != "" { // fixes bug in which you error then go to results screen
            topInfoText.text = "Assign up to 50 points for this \(category)."
        }
        
        // round button corners
        compareExpertScoresButton.layer.cornerRadius = 0.02 * compareExpertScoresButton.bounds.size.width
        compareExpertScoresButton.clipsToBounds = true
    }
    
    // score total math
    let step = 0.5
    
    func getHalfStep(value: Float) -> Double {
        let roundedValue = round(Double(value) / step) * step
        let numberWithOneDecimal = (Double(roundedValue))
        return numberWithOneDecimal
    }
    
    func getTotalScore() -> Float {
        let scores = sliderAroma.value + sliderAppearance.value + sliderFlavor.value + sliderMouthfeel.value + sliderImpression.value
        return scores
    }
    
    func resetTotal(total: Float) {
        let roundedValue = round(Double(total) / step) * step
        let totalNoTrailingZero = String(format: "%g", roundedValue)
        self.scoreOutputTotal.text = "\(totalNoTrailingZero) of 50"
    }
    
    // update category scores on live slider change
    
    @IBAction func scoreInputAroma(_ sender: UISlider) {
        let sliderValue = getHalfStep(value: sender.value)
        self.scoreOutputAroma.text = "\(sliderValue) of 12"
    }

    @IBAction func scoreInputAppearance(_ sender: UISlider) {
        let sliderValue = getHalfStep(value: sender.value)
        self.scoreOutputAppearance.text = "\(sliderValue) of 3"
    }
    
    @IBAction func scoreInputFlavor(_ sender: UISlider) {
        let sliderValue = getHalfStep(value: sender.value)
        self.scoreOutputFlavor.text = "\(sliderValue) of 20"
    }
    
    @IBAction func scoreInputMouthfeel(_ sender: UISlider) {
        let sliderValue = getHalfStep(value: sender.value)
        self.scoreOutputMouthfeel.text = "\(sliderValue) of 5"
    }
    
    @IBAction func scoreInputImpression(_ sender: UISlider) {
        let sliderValue = getHalfStep(value: sender.value)
        self.scoreOutputImpression.text = "\(sliderValue) of 10"
    }
    
    // only update total and score range on slider touch up
    
    @IBAction func allSlidersTouchUpInside(_ sender: UISlider) { actionsOnSliderTouchUp() }
    @IBAction func allSlidersTouchUpOutside(_ sender: UISlider) { actionsOnSliderTouchUp() }
    
    func actionsOnSliderTouchUp() {
        let trainerTotal = getTotalScore()
        resetTotal(total: trainerTotal)
        highlightScoreTotal()
        scoreRangeTitle.text = BeerRangeInfoBot().rangeTitle(total: trainerTotal)
        scoreRangeDescription.text = BeerRangeInfoBot().rangeDescription(total: trainerTotal)
    }
    
    // the first time a slider is moved, highlight score total and button to help user
    func highlightScoreTotal() {
        var functionHasRunOnce = false
        if functionHasRunOnce == false {
            functionHasRunOnce = true
            compareExpertScoresButton.setTitle("✓ Compare Expert Scores ", for: .normal)
            let darkgreen = UIColor(red:0.12, green:0.51, blue:0.24, alpha:1.0)
            compareExpertScoresButton.backgroundColor = darkgreen
            scoreOutputTotal.textColor = darkgreen
        }
    }
    
    // store user intputs when clicking Compare Expert Scores button
    @IBAction func storeTrainerScoresheet(_ sender: UIButton) {
        
        // scores
        beerData.scoresheetTrainer.aroma       =   getHalfStep(value: sliderAroma.value)
        beerData.scoresheetTrainer.appearance  =   getHalfStep(value: sliderAppearance.value)
        beerData.scoresheetTrainer.flavor      =   getHalfStep(value: sliderFlavor.value)
        beerData.scoresheetTrainer.mouthfeel   =   getHalfStep(value: sliderMouthfeel.value)
        beerData.scoresheetTrainer.impression  =   getHalfStep(value: sliderImpression.value)
        beerData.scoresheetTrainer.total       =   getHalfStep(value: getTotalScore()) // total
        
        // capture beer data from current rating sessions
        beerData.scoresheetTrainer.beer        =   beerData.userSelectedBeer
        beerData.scoresheetTrainer.brewery     =   beerData.userSelectedBrewery
        beerData.scoresheetTrainer.category    =   helperBot.getCategoryFromSelectedBeer()

    }
}
