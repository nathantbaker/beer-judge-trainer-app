//
//  ScoresheetComparisonBot.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//


import Foundation

// class for calculating results math
class ScoresheetComparisonBot {
    
    let beerData = BeerDataFetcher.sharedData
    let helpBot = HelperFunctions()
    
    // function that uses the user selected beer to build the scoresheetExpert scoresheet based on averaging all expert scoresheets tied to a beer
    func averageExpertScoresheets() {
        
        // gather all exeprt scoresheets tied to a beer
        let targetBeerObject = helpBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
        let expertScoresheets = targetBeerObject.scoresheets
        let number = expertScoresheets.count
        print("number of scoresheets: \(number)")
        
        var aromas = [Double]()
        var appearances = [Double]()
        var flavors = [Double]()
        var mouthfeels = [Double]()
        var impressions = [Double]()
        var totals = [Double]()
        
        for scoresheet in expertScoresheets {
            aromas.append(scoresheet.aroma)
            appearances.append(scoresheet.appearance)
            flavors.append(scoresheet.flavor)
            mouthfeels.append(scoresheet.mouthfeel)
            impressions.append(scoresheet.impression)
            totals.append(scoresheet.total)
        }
        
        func getAvg (array: [Double]) -> Double {
            let avg = array.reduce(0, +) / Double(array.count)
            return (avg * 10).rounded() / 10 // round up to 1 decimal place
        }
        
        // set expert scoreseet based on averages
        
        // scores
        beerData.scoresheetExpert.aroma       =   getAvg(array: aromas)
        beerData.scoresheetExpert.appearance  =   getAvg(array: appearances)
        beerData.scoresheetExpert.flavor      =   getAvg(array: flavors)
        beerData.scoresheetExpert.mouthfeel   =   getAvg(array: mouthfeels)
        beerData.scoresheetExpert.impression  =   getAvg(array: impressions)
        beerData.scoresheetExpert.total       =   getAvg(array: totals)
        
        // capture beer data from current rating sessions
        beerData.scoresheetExpert.beer        =   beerData.userSelectedBeer
        beerData.scoresheetExpert.brewery     =   beerData.userSelectedBrewery
        
    }

    
}

