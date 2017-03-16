//
//  HomeController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let BeerData = BeerDataFetcher()
    
    // some buttons for testing
    @IBAction func GetBreweries(_ sender: UIButton) {
        print(BeerData.breweries)
    }
    
    @IBAction func GetBeers(_ sender: UIButton) {
        print(BeerData.beer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch all beer resources on load
        print("GATHERING RESOURCES")
        BeerData.FetchAllBeerResources()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

