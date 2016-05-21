//
//  MainPageViewController.swift
//  SDP
//
//  Created by khalid on 3/13/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var uname_text: UITextField!
    @IBOutlet weak var pass_text: UITextField!
    
    let a = Authentication();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login_button(sender: AnyObject) {
        
        if(uname_text.text != "" && pass_text.text != ""){
            if(a.authenticate_user(uname_text.text!, pass: pass_text.text!)){
                if(Authentication.role_retrieve() == "consumer"){
                    performSegueWithIdentifier("loggedin_segue", sender: self);
                }else{
                    performSegueWithIdentifier("provider_segue", sender: self);
                    
                }
                
            }

        }
        
        
        
    }

    @IBAction func go_create_user_page(sender: AnyObject) {
        
        performSegueWithIdentifier("create_user_segue", sender: self);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
