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
    
    @IBAction func GetBreweries(_ sender: UIButton) {
        
        BeerData.GetResource(endpoint: "breweries") {
            breweryJSON in
            print("Data: \(breweryJSON)")
        }
    }
    
    @IBAction func GetBeers(_ sender: UIButton) {
        BeerData.GetResource(endpoint: "beers") {
            beerJSON in
            print("Data: \(beerJSON)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

