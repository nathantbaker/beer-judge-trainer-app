//
//  HomeController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let beerData = BeerDataFetcher()
    let helperBot = HelperFunctions()
    
    // intial data shown for pickers
    var brewerySelectOptions = ["Select Brewery"]
    var beerSelectOptions = ["Select Beer"]
    var userSelectedBrewery = String()
    var userSelectedBeer = String()
    
    // populate brewery picker with data
    func loadBreweryPickerData() {
        // gather brewery data
        BeerDataFetcher().getResource(endpoint: "breweries") { [weak self](data) in
            // store it for later
            self?.beerData.setBreweryData(breweryData: data)
            // format data for picker
            let breweryData = self?.helperBot.convertArrayOfDictionariesToArray(rawData: data, filterKey: "brewery_name")
            self?.brewerySelectOptions = breweryData!
            self?.SelectBrewery.reloadAllComponents()   // reload picker interface
        }
    }
    
    // populate beer picker with data
    func loadBeerPickerData() {
        // gather beer data
        BeerDataFetcher().getResource(endpoint: "beers") { [weak self](data) in
            // store it for later
            self?.beerData.setBeerData(beerData: data)
            // format data for picker
            let BeerNames = self?.helperBot.convertArrayOfDictionariesToArray(rawData: data, filterKey: "beer_name")
            self?.beerSelectOptions = BeerNames!
            self?.SelectBeer.reloadAllComponents()  // reload picker interface
        }
    }
    
    // picker settings
    
        // pickers on home view
        @IBOutlet weak var SelectBrewery: UIPickerView!
        @IBOutlet weak var SelectBeer: UIPickerView!
    
        // function to filter beer picker by brewery selected
        func returnAllBeersFromBrewery( brewery: String ) -> [String] {
            return ["Best Beer Eva", "Second Best"]
        }
    
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
                let valueSelected = brewerySelectOptions[row] as String
                userSelectedBrewery = valueSelected
                beerSelectOptions = returnAllBeersFromBrewery(brewery: userSelectedBrewery)
                self.SelectBeer.reloadAllComponents() // redraw beer picker
                print(userSelectedBrewery)
            }
            
            if( pickerView == SelectBeer ) {
                let valueSelected = beerSelectOptions[row] as String
                userSelectedBeer = valueSelected
                print(userSelectedBeer)
            }
            
        }


    // some buttons for testing
    @IBAction func getBreweries(_ sender: UIButton) {
        print(beerData.scoresheets)
    }
    @IBAction func getBeers(_ sender: UIButton) {
        print(beerData.categories)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // fetch resources needed for home view pickers
        loadBreweryPickerData()
        loadBeerPickerData()
        // get the rest of it, except what we already have
        beerData.fetchAllBeerResources()
        
        // set picker data and settings on load of home view
            self.SelectBrewery.dataSource = self
            self.SelectBrewery.delegate = self
            self.SelectBeer.dataSource = self
            self.SelectBeer.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

