//
//  ResultsController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    
    let apiData = BeerDataFetcher.sharedData

    // view elements
    @IBOutlet weak var RateAnotherBeer: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // round button corners
        RateAnotherBeer.layer.cornerRadius = 0.02 * RateAnotherBeer.bounds.size.width
        RateAnotherBeer.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

