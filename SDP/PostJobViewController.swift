//
//  PostJobViewController.swift
//  SDP
//
//  Created by khalid on 4/12/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit


class PostJobViewController: UIViewController {
    
    @IBOutlet weak var title_textfield: UITextField!
    @IBOutlet weak var desc_textfield: UITextField!
    @IBOutlet weak var subcatid_input: UITextField!
    @IBOutlet weak var timestamp_input: UITextField!
    
    @IBAction func PostJobAction(sender: AnyObject) {
        Jobs.postJob(title_textfield.text!, desc: desc_textfield.text!, subcatid: subcatid_input.text!, lifetime: timestamp_input.text!);
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)

    }
    

}
