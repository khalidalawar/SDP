//
//  Authentication.swift
//  SDP
//
//  Created by khalid on 2/27/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class Authentication {
    
    static var ret = false;
    

    static func token_retrieve()->String{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        return appDelegate.token
    }
    
    static func accid_retrieve()->String{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        return appDelegate.accid
    }
    
    static func set_accid(str : String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        appDelegate.accid = str;
    }
    
    
    static func role_retrieve()->String{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        return appDelegate.role
    }
    
    static func set_role(str : String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        appDelegate.role = str;
    }

    
//    static func auth_token(str:String )-> String {
//        let request_type = "test_token";
//        
//        let url = NSURL(string: "http://SDP.nfshost.com/authentication.php")
//        let request = NSMutableURLRequest(URL: url!)
//        
//        let bodyData = "request_type=" + request_type + "&token=" + str;
//        request.HTTPMethod = "POST"
//        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
//        
//        let semaphore = dispatch_semaphore_create(0);
//
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
//                
//            let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
//
//            print("txt: " + txt);
//                if(txt == "no"){
//                    Authentication.ret = false;
//                }else{
//                    Authentication.ret = true;
//                }
//            
//            
//            dispatch_semaphore_signal(semaphore);
//
//            
//        }
//        task.resume();
//        
//        
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//        
//        return Authentication.ret;
//        
//    }
    
    
    static func set_token(str : String ){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        appDelegate.token = str;
    }

    
    
    func authenticate_user(let uname : String , let pass : String)->Bool{
        let request_type = "authenticate_user";
        
        let url = NSURL(string: "http://SDP.nfshost.com/authentication.php")
        let request = NSMutableURLRequest(URL: url!)

        let bodyData = "request_type=" + request_type + "&uname=" + uname + "&pass=" + pass;
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
       // Authentication.ret = false;
        let semaphore = dispatch_semaphore_create(0);

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
                       // print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
                if(txt == "no user/password combination found"){
                    print("\n" + txt );
                    Authentication.ret = false;

                }else{
                
                print(txt);
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    
                    
                        Authentication.set_token(json["token"] as! String)
                        Authentication.set_accid( json["accid"] as! String )
                        Authentication.set_role(json["role"] as! String)
                        print(Authentication.role_retrieve());
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }

                
                print ("token: " + appDelegate.token)
                    Authentication.ret = true;

                }
            dispatch_semaphore_signal(semaphore);


        }
        task.resume();
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        
        return Authentication.ret;

      

        
    }

    func create_user_function (let uname : String,let fname : String,let lname : String,let email : String,let phone : String, let pass : String , let server_provider : Bool){

        
        let request_type = "create_user";
        
        
        let url = NSURL(string: "http://SDP.nfshost.com/authentication.php")
        let request = NSMutableURLRequest(URL: url!)
        
        var provider = String();
        
        if(server_provider){
            provider = "2";
        }else{
            provider = "1";
        }
        
        // modify the request as necessary, if necessary
        let bodyData = "request_type=" + request_type+"&uname=" + uname + "&fname=" + fname + "&lname=" + lname + "&email=" + email + "&phone=" + phone + "&pass=" + pass + "&server_provider=" + provider;
        
        
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                
        }

    }

}