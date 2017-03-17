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
    
    var brewerySelectOptions = ["Select Brewery"]
    
    func loadBreweryPickerData() {
        
        print("load that menu")
        
        BeerDataFetcher().getResource(endpoint: "breweries") { [weak self](data) in
            
            let breweryData = self?.helperBot.convertArrayOfDictionariesToArray(rawData: data)
            self?.brewerySelectOptions = breweryData!
            self?.SelectBrewery.reloadAllComponents()
        
        }
    }
    
    // select brewery picker
    @IBOutlet weak var SelectBrewery: UIPickerView!
    
    // sets number picker columns
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // brewery picker methods
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return brewerySelectOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return brewerySelectOptions[row]
    }
    
    // store value selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let valueSelected = brewerySelectOptions[row] as String
        print(valueSelected)
    }
    
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
        
        loadBreweryPickerData()
        if allResourcesFetched == false {
            beerData.fetchAllBeerResources()
            print("GATHERING RESOURCES")
        }
        
        // load brewery picker data
            self.SelectBrewery.dataSource = self
            self.SelectBrewery.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

