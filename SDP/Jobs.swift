//
//  Jobs.swift
//  SDP
//
//  Created by khalid on 4/5/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import Foundation

class Jobs {
    
    static var ret : Bool = false;
    
    static func postJob( title : String , desc : String ,  subcatid : String ,  lifetime : String )->Bool{
        
        let request_type = "createJob";
        
        let url = NSURL(string: "http://SDP.nfshost.com/createJob.php")
        let request = NSMutableURLRequest(URL: url!)
        
        let bodyData = "request_type=" + request_type + "&accid=" + Authentication.accid_retrieve() + "&thetitle=" + title + "&desc=" + desc + "&subcat_id=" + subcatid +  "&lifetime=" + lifetime;
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let semaphore = dispatch_semaphore_create(0);
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
            print(txt);
            
            if(txt == "successfuly inserted job"){
                Jobs.ret = true;
            }else{
                Jobs.ret = false;
            }
            
            
            dispatch_semaphore_signal(semaphore);
            
            
        }
        task.resume();
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        

        
        
        
        return Jobs.ret;
    }
    
    
}
