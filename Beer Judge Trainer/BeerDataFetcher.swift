//
//  BeerDataFetcher.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import Foundation

public class BeerDataFetcher {
    
    var breweries = ""
    var beer = ""
    
    func GetResource(endpoint: String, completionHandler: @escaping (_ responseData: String) -> ()) {
        
        //  build url
        let apiRoot = "http://api.cancanawards.com/"
        let urlWithParams = apiRoot + endpoint + "/"
        let myUrl = NSURL(string: urlWithParams);
        
        // build request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // error handling
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // parse results as a string
            
            // I should call a function here that converts JSON string to a dictionary
            let results = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            let resultString = results as! String
            let typeOfResultString = type(of: resultString)
            print("resultString is a \(typeOfResultString)")

            let dataDictionary = self.convertStringToDictionary(text: resultString)
            
            let type = type(of: dataDictionary)
            print("The \(endpoint) dictionary is of this type... \(type)")
            
            let numberOfKeys = dataDictionary?.count
            print("The \(endpoint) JSON file has \(numberOfKeys) items")
            print("")

            
            // return data
            completionHandler(results as! String)
        
        }
        task.resume()
    }
    
    func GetBreweryList() {
        self.GetResource(endpoint: "breweries") {
            // when brewery data is fetched, store it locally
            data in self.breweries = data
        }
    }
    
    func GetBeerList() {
        self.GetResource(endpoint: "beers") {
            // when beer data is fetched, store it locally
            data in self.beer = data
        }
    }
    
    // take a JSON string and return
    // a dictionary of dictionaries
    // that have strings as keys and other stuff as values
    
    func convertStringToDictionary(text: String) -> [[String: AnyObject]]? {
        
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil

    }
}

