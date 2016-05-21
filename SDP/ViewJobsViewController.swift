//
//  ViewJobsViewController.swift
//  SDP
//
//  Created by khalid on 4/23/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class ViewJobsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jobs = NSMutableArray();

    
    
    struct job {
        var name : String;
        var description : String;
        var timestamp : String;
    }
    
    
    
    
    
    func load_image(urlString:String , imgView : UIImageView)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let semaphore = dispatch_semaphore_create(0);

        
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error!.description)
            } else {
                imgView.image = UIImage(data: data!)
                
                
            }
            
            dispatch_semaphore_signal(semaphore);

            
        }
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        

        
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:tableviewcellviewjobs = self.tableView.dequeueReusableCellWithIdentifier("cell")! as! tableviewcellviewjobs
        
        cell.title.text = jobs[indexPath.row]["title"] as? String;//self.items[indexPath.row]
        load_image(jobs[indexPath.row]["JP_url"]!![1] as! String, imgView: cell.img)
        
        cell.desc.text = jobs[indexPath.row]["description"] as? String;
        
        cell.jobid = jobs[indexPath.row]["job_id"] as! String ;
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! tableviewcellviewjobs!
        cell.contentView.backgroundColor = UIColor(red: CGFloat(86.0/255), green: CGFloat(66.0/255), blue: CGFloat(15.0/255), alpha: CGFloat(1.0))
        
    //    cell.contentView.backgroundColor = UIColor.redColor();
        
        
        

    }
    
    
    override func viewDidLoad() {
        
        let url = NSURL(string: "http://SDP.nfshost.com/getJobs.php")
        let request = NSMutableURLRequest(URL: url!)
        
        let bodyData = "accid=" + Authentication.accid_retrieve();
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let semaphore = dispatch_semaphore_create(0);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                
                for i in json{
                    self.jobs.addObject(i)
                }
                
               // print(self.jobs);
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            dispatch_semaphore_signal(semaphore);
            
            
        }
        task.resume();
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        self.tableView.rowHeight = 150;

        
        
      //  self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    

}
