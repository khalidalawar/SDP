//
//  ViewController.swift
//  SDP
//
//  Created by khalid on 2/27/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    
    var authentication = Authentication();

    @IBOutlet weak var password_textfield: UITextField!
    @IBOutlet weak var username_textfield: UITextField!
    @IBOutlet weak var fname_textfield: UITextField!
    @IBOutlet weak var lname_textfield: UITextField!
    @IBOutlet weak var email_textfield: UITextField!
    @IBOutlet weak var phone_textfield: UITextField!
    
    @IBOutlet weak var server_provider: UISwitch!
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func create_user(sender: AnyObject) {
        
        authentication.create_user_function(username_textfield.text!,fname: fname_textfield.text!, lname: lname_textfield.text!,email: email_textfield.text!,phone: phone_textfield.text!, pass: password_textfield.text!,server_provider: server_provider.on);

    }
}

