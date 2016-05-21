import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var description_textfield: UITextField!
    @IBOutlet weak var name_textfield: UITextField!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        
        myImageUploadRequest()
        
    }
    
    @IBAction func selectPhotoButtonTapped(sender: AnyObject) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func submit_action(sender: AnyObject) {
        
        let url = NSURL(string: "http://SDP.nfshost.com/editProfile.php")
        let request = NSMutableURLRequest(URL: url!)
        
        var bodyData = "accid=" + Authentication.accid_retrieve();
        bodyData += "&name=" + name_textfield.text!;
        
        bodyData += "&description=" + description_textfield.text!;
        
        request.HTTPMethod = "POST"
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
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        let url = NSURL(string: "http://SDP.nfshost.com/getProfile.php")
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
                
                self.name_textfield.text = json[0]["name"] as? String;
                self.description_textfield.text = json[0]["description"] as? String;
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }

            dispatch_semaphore_signal(semaphore);
            
            
        }
        task.resume();
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        
        super.viewWillAppear(animated);

    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        description_textfield.delegate = self;
        name_textfield.delegate = self;
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //myImageUploadRequest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://SDP.nfshost.com/picture_upload.php");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "type"  : "profile",
            "accid"    : Authentication.accid_retrieve()
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        
        myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            dispatch_async(dispatch_get_main_queue(),{
                self.myActivityIndicator.stopAnimating()
                self.myImageView.image = nil;
            });
            
            /*
            if let parseJSON = json {
            var firstNameValue = parseJSON["firstName"] as? String
            println("firstNameValue: \(firstNameValue)")
            }
            */
            
        }
        
        task.resume()
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    
}



extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}