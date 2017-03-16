//
//  HomeController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let beerData = BeerDataFetcher()
    
    // some buttons for testing
    @IBAction func getBreweries(_ sender: UIButton) {
        print(beerData.breweries)
    }
    
    @IBAction func getBeers(_ sender: UIButton) {
        print(beerData.beers)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch all beer resources on home view load if they haven't been gathered yet 
        if allResourcesFetched == false {
            beerData.fetchAllBeerResources()
            print("GATHERING RESOURCES")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

