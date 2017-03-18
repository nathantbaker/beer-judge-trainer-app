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
    
    // populate brewery picker with data
    func loadBreweryPickerData() {
        BeerDataFetcher().getResource(endpoint: "breweries") { [weak self](data) in // gather brewery data
            // format data
            let breweryData = self?.helperBot.convertArrayOfDictionariesToArray(rawData: data, filterKey: "brewery_name")
            self?.brewerySelectOptions = breweryData!
            self?.SelectBrewery.reloadAllComponents()   // reload picker interface
        }
    }
    
    // populate beer picker with data
    func loadBeerPickerData() {
        BeerDataFetcher().getResource(endpoint: "beers") { [weak self](data) in // gather beer data
            // format data
            let beerData = self?.helperBot.convertArrayOfDictionariesToArray(rawData: data, filterKey: "beer_name")
            self?.beerSelectOptions = beerData!
            self?.SelectBeer.reloadAllComponents()  // reload picker interface
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
                let valueSelected = brewerySelectOptions[row] as String
                print(valueSelected)
            }
            
            if( pickerView == SelectBeer ) {
                let valueSelected = beerSelectOptions[row] as String
                print(valueSelected)
            }
            
        }


    // some buttons for testing
    @IBAction func getBreweries(_ sender: UIButton) { print(beerData.breweries) }
    @IBAction func getBeers(_ sender: UIButton) { print(beerData.beers) }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // fetch all beer resources on home view load if they haven't been gathered yet
        
        loadBreweryPickerData()
        loadBeerPickerData()
        if allResourcesFetched == false {
            beerData.fetchAllBeerResources()
            print("GATHERING RESOURCES")
        }
        
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

