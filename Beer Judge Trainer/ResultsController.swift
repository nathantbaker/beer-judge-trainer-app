//
//  ResultsController.swift
//  Beer Judge Trainer
//
//  Created by Nate on 3/14/17.
//  Copyright © 2017 Nathan T. Baker. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    
    @IBAction func takeScreenshot(_ sender: Any) {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
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

