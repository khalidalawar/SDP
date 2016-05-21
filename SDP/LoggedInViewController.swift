//
//  LoggedInViewController.swift
//  SDP
//
//  Created by khalid on 3/22/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    @IBAction func profile_segue(sender: AnyObject) {
        performSegueWithIdentifier("profile", sender: self);
        
    }
    
    @IBAction func post_segue(sender: AnyObject) {
        
        performSegueWithIdentifier("post_job", sender: self);

        
    }
    
    
    @IBAction func view_profile_segue(sender: AnyObject) {
        performSegueWithIdentifier("viewProfile", sender: self);

    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test_token(sender: AnyObject) {
        let token = Authentication.token_retrieve();
//        if(Authentication.auth_token("EV38_fBxlYqr1F$!pjSZg+V5JGecdR@RA^!z8p*ucmVd#N2f&U")){
//      //      print("authed");
//        }else{
//       //     print("not authed");
//        }
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
