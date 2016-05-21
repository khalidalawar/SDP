//
//  ProviderViewController.swift
//  SDP
//
//  Created by khalid on 4/23/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {
    
    @IBAction func viewjobs_segue(sender: AnyObject) {
        performSegueWithIdentifier("view_jobs", sender: self);

        
    }
    

}
