//
//  ViewProfileViewController.swift
//  SDP
//
//  Created by khalid on 4/13/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var test: UIImageView!
    
    var json = NSArray();
    
    
    let reuseIdentifier = "cell"
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.json.count - 2;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! pictures
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
     //   cell.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        cell.load_image(json[indexPath.row + 2] as! String);
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func load_image(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()

        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error!.description)
            } else {
                self.test.image = UIImage(data: data!)
            
            
            }
        
        
            
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL(string: "http://SDP.nfshost.com/picture_download.php")
        let request = NSMutableURLRequest(URL: url!)
        
        let bodyData = "&imagefor=profile&accid="+Authentication.accid_retrieve();
        
        
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let semaphore = dispatch_semaphore_create(0);
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            
             let txt = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String;
            
            
           
            
      //      print(txt);
           // self.load_image(txt);
           
           
            do {
                 self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                
                
                for(var i : Int = 2;i < self.json.count;i++){
          //          self.load_image(self.json[i] as! String);
                }
                
          //      let decodedData = NSData(base64EncodedString: base64String!, options: NSDataBase64DecodingOptions(rawValue: 0))

                
             //   self.test.image = UIImage(data: );
                
               
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }

            
            
            dispatch_semaphore_signal(semaphore);
            
            
        }
        task.resume();
        
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        
        
        
    }

}
