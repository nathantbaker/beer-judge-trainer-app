//
//  HomeController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let beerData = BeerDataFetcher.sharedData
    let helperBot = HelperFunctions()
    
    // intial data shown for pickers
    var brewerySelectOptions = ["Select Brewery"]
    var beerSelectOptions = ["Select Beer"]
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // all api data has been parsed into objects within this closure
        beerData.FetchAllBeerResources() { completeMessage in
            print("Status of Parsing API Data: \(completeMessage)")
            self.loadBreweryPicker()
            self.loadBeerPicker()
        }
        
        // set picker data and settings on load of home view
        self.SelectBrewery.dataSource = self
        self.SelectBrewery.delegate = self
        self.SelectBeer.dataSource = self
        self.SelectBeer.delegate = self
    }
    
    // dynamically set Rate button and helper info at bottom
    // by the time this runs, there is a default selected beer and brewery
    func setTextofRateButton() {
        // set text of Rate button
        rateBeerButton.setTitle( "Rate \(beerData.userSelectedBeer)" , for: .normal )
        // give full beeer name under Rate button
        fullBeerNameLabel.text = "\(beerData.userSelectedBrewery)'s \(beerData.userSelectedBeer)"
        fullBeerNameLabel.textColor = UIColor.black // it could be red from being an error message
        // set beer category under Rate button
        let targetBeerObject = helperBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
        beerCategoryLabel.text = targetBeerObject.category
    }
    @IBOutlet weak var rateBeerButton: UIButton!
    @IBOutlet weak var fullBeerNameLabel: UILabel!
    @IBOutlet weak var beerCategoryLabel: UILabel!
    
    // error handling
    // don't allow users to click Rate Beer if they didn't select anything
    @IBAction func rateBeerOrError(_ sender: UIButton) {
        // if nothing is select, error. If one thing is selected, the cooresponding thing is auto-selected
        if beerData.userSelectedBrewery == "none" && beerData.userSelectedBeer == "none" {
            fullBeerNameLabel.textColor = UIColor.red
            fullBeerNameLabel.text = "Oops, you still need select a beer before rating it!"
        } else {
            // send them to the rating view
            self.performSegue(withIdentifier: "RateBeerSegue", sender: self)
        }
    }
    
    // memory shiz
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // picker settings
    
        // pickers on home view
        @IBOutlet weak var SelectBrewery: UIPickerView!
        @IBOutlet weak var SelectBeer: UIPickerView!

        // picker column number
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // show number of items based on current picker
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == SelectBrewery { return brewerySelectOptions.count }
            if pickerView == SelectBeer { return beerSelectOptions.count }
            return 0
        }
        
        // get the values to display based on picker
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == SelectBrewery { return brewerySelectOptions[row] }
            if pickerView == SelectBeer { return beerSelectOptions[row] }
            return nil
        }
    
        // store selected picker data
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            if( pickerView == SelectBrewery ) {
                beerData.userSelectedBrewery = brewerySelectOptions[row] as String
                beerSelectOptions = filterBeerBasedOnBrewery()
                self.SelectBeer.reloadAllComponents() // redraw beer picker
                // store current beer row as user select in case users presses Rate before selecting the auto selected beer
                if beerData.userSelectedBrewery != "none" { // dont' crash if still loading data
                    beerData.userSelectedBeer = beerSelectOptions[0] as String
                    setTextofRateButton()
                    print("User selected brewery: \(beerData.userSelectedBrewery)")
                }

            }
            
            if( pickerView == SelectBeer ) {
                beerData.userSelectedBeer = beerSelectOptions[row] as String
                brewerySelectOptions = filterBreweryBasedOnBeer()
                self.SelectBrewery.reloadAllComponents() // redraw beer picker
                // store current brewery row as user select in case users presses Rate before selecting the auto selected brewery
                if beerData.userSelectedBeer != "none" { // dont' crash if still loading data
                    beerData.userSelectedBrewery = brewerySelectOptions[0] as String
                    setTextofRateButton() // dynamically change Rate button
                    print("User selected beer: \(beerData.userSelectedBeer)")
                }
            }
        }
    
    //picker functions
    
    func loadBreweryPicker() {
        // populate brewery picker with brewery names
        self.brewerySelectOptions = [] // clear default value
        for brewery in beerData.breweries {
            self.brewerySelectOptions.append(brewery.name)
        }
        self.SelectBrewery.reloadAllComponents() // reload picker interface
    }
    
    func loadBeerPicker() {
        // populate beer picker with beer names
        self.beerSelectOptions = [] // clear default value
        for beer in beerData.beers {
            self.beerSelectOptions.append(beer.name)
        }
        self.SelectBeer.reloadAllComponents() // reload picker interface
    }
    
    func filterBeerBasedOnBrewery() -> [String] {
        setTextofRateButton() // dynamically change Rate button
        if beerData.userSelectedBrewery != "none" { // dont' crash if still loading data
            let breweryObject = helperBot.getBreweryObjectFromName(brewery: beerData.userSelectedBrewery)
            return breweryObject.beers // return beers on a brewery
        } else {
            return ["Select Beer"]
        }
    }
    
    func filterBreweryBasedOnBeer() -> [String] {
        setTextofRateButton() // dynamically change Rate button
        if beerData.userSelectedBeer != "none" { // dont' crash if still loading data
            let beerObject = helperBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
            let breweryOfBeer = beerObject.brewery.name
            return [breweryOfBeer] // return brewery name within array for picker
        } else {
            return ["Select Beer"]
        }
    }
    
    @IBAction func resetBreweryPicker(_ sender: UIButton) {
        self.loadBreweryPicker()
        print("reset brewery picker")
    }

    @IBAction func resetBeerPicker(_ sender: UIButton) {
        self.loadBeerPicker()
        print("reset brewery picker")
    }
}

