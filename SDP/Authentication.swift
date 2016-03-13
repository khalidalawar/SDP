//
//  Authentication.swift
//  SDP
//
//  Created by khalid on 2/27/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import Foundation


class Authentication {
    
    
    func authenticate_user(let uname : String , let pass : String){
        let request_type = "authenticate_user";
        
        let url = NSURL(string: "http://SDP.nfshost.com/authentication.php")
        let request = NSMutableURLRequest(URL: url!)

        let bodyData = "request_type=" + request_type + "&uname=" + uname + "&pass=" + pass;
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                
        }

        
    }

    func create_user_function (let uname : String,let fname : String,let lname : String,let email : String,let phone : String, let pass : String){

        
        let request_type = "create_user";
        
        
        let url = NSURL(string: "http://SDP.nfshost.com/authentication.php")
        let request = NSMutableURLRequest(URL: url!)
        
        // modify the request as necessary, if necessary
        let bodyData = "request_type=" + request_type+"&uname=" + uname + "&fname=" + fname + "&lname=" + lname + "&email=" + email + "&phone=" + phone + "&pass=" + pass;
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                
        }

    }

}