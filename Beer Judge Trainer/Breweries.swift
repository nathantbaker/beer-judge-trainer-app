//
//  Breweries.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/17/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

class Breweries {
    
    private var _name: String = ""
    
    var name: String {
            set { _name = newValue }
            get { return _name }
        }
}
