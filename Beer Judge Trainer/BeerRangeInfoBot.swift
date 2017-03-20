//
//  BeerRangeLanguageBot.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/20/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

class BeerRangeInfoBot {

    // BJCP SCORE RANGES
    //
    // Outstanding (45 - 50):  World-class example of style.
    // Excellent   (38 - 44):  Exemplifies style well, requires minor fine-tuning.
    // Very Good   (30 - 37):  Generally within style parameters, some minor flaws.
    // Good        (21 - 29):  Misses the mark on style and/or minor flaws.
    // Fair        (14 - 20):  Off flavors/aromas or major style deficiencies. Unpleasant.
    // Problematic (00 - 13):  Major off flavors and aromas dominate. Hard to drink.

    
    func rangeTitle(total: String) -> String {
        
        let testNumber = Int(total)
        
        if testNumber! <= 13 {
            return "In the Problematic range"
        } else if testNumber! <= 20 {
            return "In the Fair range"
        } else if testNumber! <= 29 {
            return "In the Good In range"
        } else if testNumber! <= 37 {
            return "In the Very Good range"
        } else if testNumber! <= 44 {
            return "In the Excellent range"
        } else if testNumber! <= 50 {
            return "In the Outstanding range"
        } else {
            return ""
        }
    }
    
    func rangeDescription(total: String) -> String {
        
        let testNumber = Int(total)
        
        if testNumber! <= 13 {
            return "Beers scored between 0-13 have major off flavors and aromas dominate. Hard to drink."
        } else if testNumber! <= 20 {
            return "Beers scored between 14-20 have off flavors/aromas or major style deficiencies. Unpleasant."
        } else if testNumber! <= 29 {
            return "Beers scored between 21-29 miss the mark on style and/or minor flaws."
        } else if testNumber! <= 37 {
            return "Beers scored between 30-37 are generally within style parameters, some minor flaws."
        } else if testNumber! <= 44 {
            return "Beers scored between 38-44 exemplifies style well, requires minor fine-tuning."
        } else if testNumber! <= 50 {
            return "Beers scored between 45-50 are world-class example of the style"
        } else {
            return ""
        }
    
    }
}
