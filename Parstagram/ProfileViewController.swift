//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Suma Valli on 3/18/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var myPosts = [PFObject]();
    var currentUser:String = "";
        
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self;
        myTableView.dataSource = self;
        
        let defaults = UserDefaults.standard;
        currentUser = defaults.object(forKey: "currentUser") as! String
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts");
        //let usersList = PFObject(className: "Users");
        //let user = usersList[currentUser] as! PFUser//String(describing: PFUser.current()?.objectId)
        //let objectId = user.objectId
        query.whereKey("authorId", contains: currentUser)//.whereKey("author", equalTo: userId)//.includeKey("author");
        //print("UserId: \(String(describing: objectId))")
        query.limit = 20;
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.myPosts = posts!
                self.myTableView.reloadData();
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of posts for currentUser is \(myPosts.count)")
        return myPosts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MyPostCell") as! MyPostCell;
        let rowNum = myPosts.count - indexPath.row - 1;
        let post = myPosts[rowNum];
        let user = post["author"] as! PFUser;
        
        //if user.username == currentUser {
            cell.myUsernameLabel.text = user.username;
            cell.myHeaderUsernameLabel.text = user.username;
            cell.myCaptionLabel.text = post["caption"] as? String;
            
            let imageFile = post["image"] as! PFFileObject;
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.myPhotoView.af.setImage(withURL: url);
       // }
        
        
        return cell;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
