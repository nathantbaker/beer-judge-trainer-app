//
//  BeerRangeLanguageBot.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/20/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation
import UIKit // for UIColor

// class for returning dynamic language about how a beer is rated and how close a rater gets

class DynamicLanguageBot {

    // BJCP SCORE RANGES
    //
    // Outstanding (45 - 50):  World-class example of style.
    // Excellent   (38 - 44):  Exemplifies style well, requires minor fine-tuning.
    // Very Good   (30 - 37):  Generally within style parameters, some minor flaws.
    // Good        (21 - 29):  Misses the mark on style and/or minor flaws.
    // Fair        (14 - 20):  Off flavors/aromas or major style deficiencies. Unpleasant.
    // Problematic (00 - 13):  Major off flavors and aromas dominate. Hard to drink.

    
    func rangeTitle(total: Float) -> String {
    
        if total <= 13 {
            return "In the Problematic range"
        } else if total <= 20 {
            return "In the Fair range"
        } else if total <= 29 {
            return "In the Good range"
        } else if total <= 37 {
            return "In the Very Good range"
        } else if total <= 44 {
            return "In the Excellent range"
        } else if total <= 50 {
            return "In the Outstanding range"
        } else {
            return ""
        }
    }
    
    func rangeDescription(total: Float) -> String {
        
        if total <= 13 {
            return "Beers scored between 0-13 have major off flavors and aromas dominate. They are hard to drink."
        } else if total <= 20 {
            return "Beers scored between 14-20 have off flavors/aromas or major style deficiencies. They are unpleasant."
        } else if total <= 29 {
            return "Beers scored between 21-29 miss the mark on style and/or have minor flaws."
        } else if total <= 37 {
            return "Beers scored between 30-37 are generally within style parameters, and may have some minor flaws."
        } else if total <= 44 {
            return "Beers scored between 38-44 exemplifies the style well, and only require minor fine-tuning."
        } else if total <= 50 {
            return "Beers scored between 45-50 are world-class examples of the style"
        } else {
            return ""
        }
    
    }
    
    // function to return (language, background colors) for results page after being given a double.
    
    //  Point Difference Ranges
    
    //  0-1:  Amazing       green and sparkles
    //  1-3:  Good          green
    //  4-6:  Ok            yellow
    //  6-8:  Not so close  orange
    //  8-*:  Way off       red
    //
    
    func trainerReviewTitle(pointDiff: Double) -> String {
        // convert negatives to positive
        let test = (abs(pointDiff))
        
        // amazing
        if test <= 1 {
            return "🏆 Amazing Work Beer Aficionado! "
        // good
        } else if test <= 3 {
            return "👍 Good Job Beer Connoisseur "
        // ok
        } else if test <= 6 {
            return "👌 Okay Job Beer Enthusiast "
        // no so close
        } else if test <= 8 {
            return "👎 A Bit Out Of Range Beer Fan "
        // bad
        } else {
            return "💩 Way Off This Time Beer Fan "
        }
    }
    
    func scoreTotalRange(score: Double) -> String {
        // convert negatives to positive
        let total = (abs(score))
        
        if total <= 13 {
            return "Problematic Range"
        } else if total <= 20 {
            return "Fair Range"
        } else if total <= 29 {
            return "Good Range"
        } else if total <= 37 {
            return "Very Good Range"
        } else if total <= 44 {
            return "Excellent Range"
        } else if total <= 50 {
            return "Outstanding Range"
        } else {
            return ""
        }
    }
    
    func trainerResultsBackgroundColor(pointDiff: Double) -> UIColor {
        // convert negatives to positive
        let test = (abs(pointDiff))
        
        let green: UIColor = UIColor(red:0.82, green:0.96, blue:0.82, alpha:1.0)
        let yellow: UIColor = UIColor(red:0.97, green:0.92, blue:0.75, alpha:1.0)
        let red: UIColor = UIColor(red:0.96, green:0.82, blue:0.82, alpha:1.0)
        
        if test <= 3 { return green }       // good and better  green
        else if test <= 6 { return yellow } // ok range         yellow
        else { return red }                 // meh and below    red
    }
}
