//
//  ViewController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBAction func GetBreweriesJSON(_ sender: UIButton) {
//        BeerDataFetcher().GetResource(apiResource:"breweries")
        BeerDataFetcher().GetResource(endpoint: "breweries")
    }

    @IBAction func GetBeersJSON(_ sender: UIButton) {
        BeerDataFetcher().GetResource(endpoint: "beers")
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

