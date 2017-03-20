//
//  HomeController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

//global variables available to other controllers
var userSelectedBrewery = "none"
var userSelectedBeer = "none"

class HomeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let beerData = BeerDataFetcher.sharedData
    let helperBot = HelperFunctions()
    
    // intial data shown for pickers
    var brewerySelectOptions = ["Select Brewery"]
    var beerSelectOptions = ["Select Beer"]
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchDataAndBuildInterface()
        
        // set picker data and settings on load of home view
        self.SelectBrewery.dataSource = self
        self.SelectBrewery.delegate = self
        self.SelectBeer.dataSource = self
        self.SelectBeer.delegate = self
    }
    
    // build view
    func fetchDataAndBuildInterface() {
        
        let beerData = BeerDataFetcher.sharedData
        
        // all api data has been parsed into objects within closure
        beerData.FetchAllBeerResources() { completeMessage in
            
            print("Status of Parsing API Data: \(completeMessage)")
            
            // populate brewery picker with brewery names
            self.brewerySelectOptions = [] // clear default value
            for brewery in beerData.breweries {
                self.brewerySelectOptions.append(brewery.name)
            }
            self.SelectBrewery.reloadAllComponents() // reload picker interface
            
            // populate beer picker with beer names
            self.beerSelectOptions = [] // clear default value
            for beer in beerData.beers {
                self.beerSelectOptions.append(beer.name)
            }
            self.SelectBeer.reloadAllComponents() // reload picker interface
            
            

//            // populate beer picker with data
//            self?.beerNames = (self?.helperBot.convertArrayOfDictionariesToArray(rawData: data, filterKey: "beer_name"))!
//            self?.beerSelectOptions = (self!.beerNames)
//            self?.SelectBeer.reloadAllComponents()  // reload picker interface
            
        }
    
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
                userSelectedBrewery = brewerySelectOptions[row] as String
                beerSelectOptions = filterBeerBasedOnBrewery()
                self.SelectBeer.reloadAllComponents() // redraw beer picker
                // store current beer row as user select in case users presses Rate before selecting the auto selected beer
                if userSelectedBrewery != "none" { // dont' crash if still loading data
                    userSelectedBeer = beerSelectOptions[0] as String
                    setTextofRateButton()
                    print("User selected brewery: \(userSelectedBrewery)")
                }

            }
            
            if( pickerView == SelectBeer ) {
                userSelectedBeer = beerSelectOptions[row] as String
                brewerySelectOptions = filterBreweryBasedOnBeer()
                self.SelectBrewery.reloadAllComponents() // redraw beer picker
                // store current brewery row as user select in case users presses Rate before selecting the auto selected brewery
                if userSelectedBeer != "none" { // dont' crash if still loading data
                    userSelectedBrewery = brewerySelectOptions[0] as String
                    setTextofRateButton() // dynamically change Rate button
                    print("User selected beer: \(userSelectedBeer)")
                }
            }
        }
    
    //picker filtering functions
    
        // function to filter beer picker by brewery selected
    func filterBeerBasedOnBrewery() -> [String] {
            
            setTextofRateButton() // dynamically change Rate button
            return helperBot.returnAllBeersFromBrewery(brewery: userSelectedBrewery)
        }
    
        // function to filter brewery picker by beer selected
        func filterBreweryBasedOnBeer() -> [String] {
            
//            let breweries = beerData.getBreweryData()
//            let beer = beerData.getBeerData()
//            
//            return helperBot.returnBreweryOfBeer(
//                beerData: beer,
//                breweryData: breweries,
//                filterWord: userSelectedBeer
//            )
            return [""]
        }
    
        // reset brewery picker
        @IBAction func resetBreweryPicker(_ sender: UIButton) {
            self.SelectBrewery.reloadAllComponents() // redraw brewery picker
            print("reset brewery picker")
        }

        // reset beer picker
        @IBAction func resetBeerPicker(_ sender: UIButton) {
            self.SelectBeer.reloadAllComponents() // redraw beer picker
            print("reset beer picker")
        }
    
    // dynamically set Rate button and helper info
    @IBOutlet weak var rateBeerButton: UIButton!
    @IBOutlet weak var fullBeerNameLabel: UILabel!
    @IBOutlet weak var beerCategoryLabel: UILabel!
    
    // by the time this runs, there is a default selected beer and brewery
    func setTextofRateButton() {
        rateBeerButton.setTitle( "Rate \(userSelectedBeer)" , for: .normal )
        fullBeerNameLabel.textColor = UIColor.black // it could be red from being an error message
        fullBeerNameLabel.text = "\(userSelectedBrewery)'s \(userSelectedBeer)"
        beerCategoryLabel.text = "Red Ale" // need to make this dynamic still
    }

    //  don't allow users to click Rate Beer if they didn't select anything
    @IBAction func rateBeerOrError(_ sender: UIButton) {
        // if nothing is select, error. If one thing is selected, the cooresponding thing is auto-selected
        if userSelectedBrewery == "none" && userSelectedBeer == "none" {
            fullBeerNameLabel.textColor = UIColor.red
            fullBeerNameLabel.text = "Oops, you still need select a beer before rating it!"
        } else {
            // send them to the rating view
            self.performSegue(withIdentifier: "RateBeerSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

