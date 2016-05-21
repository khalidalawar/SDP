//
//  pictures.swift
//  SDP
//
//  Created by khalid on 4/19/16.
//  Copyright © 2016 khalid. All rights reserved.
//

import UIKit

class pictures: UICollectionViewCell {

    @IBOutlet weak var picture: UIImageView!
    
    func load_image(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error!.description)
            } else {
                self.picture.image = UIImage(data: data!)
                
                
            }
            
            
            
        }
        task.resume()
        
    }

    
}
