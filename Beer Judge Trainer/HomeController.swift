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
    
    var brewerySelectOptions = BeerDataFetcher().returnArrayOfBreweries()


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
        if allResourcesFetched == false {
            beerData.fetchAllBeerResources()
            print("GATHERING RESOURCES")
        }
        
        // brewery picker
        self.SelectBrewery.dataSource = self
        self.SelectBrewery.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

