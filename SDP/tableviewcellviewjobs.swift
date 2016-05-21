//
//  tableviewcellviewjobs.swift
//  SDP
//
//  Created by khalid on 4/24/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class tableviewcellviewjobs: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    var jobid = String();
    
    
    @IBAction func place_bid() {
        let request_type = "placebid";
        
        let url = NSURL(string: "http://SDP.nfshost.com/placeBid.php")
        let request = NSMutableURLRequest(URL: url!)
        
        let bodyData = "request_type=" + request_type + "&sp_accid=" + Authentication.accid_retrieve() + "&amount=" + amount.text! + "&job_id=" + jobid;        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let semaphore = dispatch_semaphore_create(0);
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
            print(txt);
            
            
            
            
            dispatch_semaphore_signal(semaphore);
            
            
        }
        task.resume();
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    
    
    let alert = UIAlertView()
    alert.title = "Bid Placed"
    alert.message = "You have successfully"
    alert.addButtonWithTitle("Dismiss")
    alert.show()
        
    }
}
