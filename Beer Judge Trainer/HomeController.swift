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
        
        // first time view loads, pull down data and build pickers
        if beerData.allDataFetched == false {
            
            beerData.FetchAllBeerResources() { completeMessage in
                
                // data status
                print("Status of Parsing API Data: \(completeMessage)")
                self.beerData.allDataFetched = true
                
                // build pickers with new data
                self.loadBreweryPicker()
                self.loadBeerPicker()
            }
            
        } else {
            
            // build pickers with old data
            self.loadBreweryPicker()
            self.loadBeerPicker()

        }
        
        // set picker data and settings on load of home view
        self.SelectBrewery.dataSource = self
        self.SelectBrewery.delegate = self
        self.SelectBeer.dataSource = self
        self.SelectBeer.delegate = self
        
        // round button corners
        rateBeerButton.layer.cornerRadius = 0.02 * rateBeerButton.bounds.size.width
        rateBeerButton.clipsToBounds = true
        
    }
    
    // dynamically set Rate button and helper info at bottom
    // by the time this runs, there is a default selected beer and brewery
    func setTextofRateButton() {
        // set text of Rate button
        print("selected beer IN setTextofRateButton function: \(beerData.userSelectedBeer)")
        rateBeerButton.setTitle( "✓ Rate \(beerData.userSelectedBeer) " , for: .normal )
        rateBeerButton.backgroundColor = UIColor(red:0.12, green:0.51, blue:0.24, alpha:1.0)
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
            
            // handle if data isn't loaded and someone selects picker
            if beerData.allDataFetched == true {
                
                beerData.userSelectedBrewery = brewerySelectOptions[row] as String // row - selected beer
                beerSelectOptions = filterBeerBasedOnBrewery()
                
                self.SelectBeer.reloadAllComponents() // redraw beer picker
                beerData.userSelectedBeer = beerSelectOptions[0] as String

                
                setTextofRateButton()
                print("User selected brewery: \(beerData.userSelectedBrewery)")
            }
        }
        
        if( pickerView == SelectBeer ) {
            
            // handle if data isn't loaded and someone selects picker
            if beerData.allDataFetched == true {
            
                beerData.userSelectedBeer = beerSelectOptions[row] as String
                print("User selected beer: \(beerData.userSelectedBeer)")
                setTextofRateButton() // dynamically change Rate button
                scrollToBreweryBasedOnBeer() // issue
            }
        }
    }
    
    
    
    //picker functions
    
    // picker header elements
    @IBOutlet weak var BreweryPickerHeader: UILabel!
    @IBOutlet weak var BeerPickerHeader: UILabel!
    @IBOutlet weak var ViewAllBeersButton: UIButton!
    
    // scroll to brewery tied to a beer name
    func scrollToBreweryBasedOnBeer() {
        if beerData.userSelectedBeer != "none" { // don't crash if still loading data
            let beerObject = helperBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
            let targetBreweryName = beerObject.brewery.name
            // find index of target name on brewerySelectOptions array
            let indexOfTarget = brewerySelectOptions.index(of: targetBreweryName)
            // first number is the index of target brewery on brewerySelectOptions array
            self.SelectBrewery.selectRow(indexOfTarget!, inComponent: 0, animated: true)
            //select beer and set info at bottom
            beerData.userSelectedBrewery = targetBreweryName
            // give full beeer name under Rate button
            fullBeerNameLabel.text = "\(beerData.userSelectedBrewery)'s \(beerData.userSelectedBeer)"
            fullBeerNameLabel.textColor = UIColor.black // it could be red from being an error message
            // set beer category under Rate button
            let targetBeerObject = helperBot.getBeerObjectFromName(beer: beerData.userSelectedBeer)
            beerCategoryLabel.text = targetBeerObject.category
        }
    }
    
    // populate brewery picker with brewery names
    func loadBreweryPicker() {
        var tempArray = [String]()
        for brewery in beerData.breweries {
            tempArray.append(brewery.name)
        }
        
        let alphebeticalArray = tempArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending}
        brewerySelectOptions = alphebeticalArray
        
        self.SelectBrewery.reloadAllComponents() // reload picker interface
    }
    
    // populate beer picker with beer names
    func loadBeerPicker() {
        var tempArray = [String]()
        for beer in beerData.beers {
            tempArray.append(beer.name)
        }
        
        let alphebeticalArray = tempArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending}
        beerSelectOptions = alphebeticalArray
        
        self.SelectBeer.reloadAllComponents() // reload picker interface
    }
    
    func filterBeerBasedOnBrewery() -> [String] {
        
        if beerData.userSelectedBrewery != "none" { // don't crash if still loading data
            
            setTextofRateButton() // dynamically change Rate button
            BeerPickerHeader.text = "\(beerData.userSelectedBrewery)'s Beers"
            ViewAllBeersButton.isHidden = false
            
            let breweryObject = helperBot.getBreweryObjectFromName(brewery: beerData.userSelectedBrewery)
            return breweryObject.beers // return beers on a brewery
            
        } else {
            return ["Select Beer"]
        }
    }
    
    
    // reset beer picker
    @IBAction func resetBeerPicker(_ sender: UIButton) {
        BeerPickerHeader.text = "Find Beer Name"
        ViewAllBeersButton.isHidden = true
        self.loadBeerPicker()
        print("reset brewery picker")
    }
}

