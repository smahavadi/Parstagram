//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Suma Valli on 3/17/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]();
    var numOfPosts = Int()
    
    let myRefreshControl = UIRefreshControl();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts");
        query.includeKey("author");
        numOfPosts = 10;
        query.limit = numOfPosts;
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData();
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    func loadMorePosts() {
        let query = PFQuery(className: "Posts");
        query.includeKey("author");
        numOfPosts = numOfPosts + 5;
        query.limit = numOfPosts;
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData();
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell;
        print("Row:\(indexPath.row)");
        let rowNum = posts.count - indexPath.row - 1;
        print("Row Number is:\(rowNum)");
        let post = posts[rowNum];
        let user = post["author"] as! PFUser;
        cell.usernameLabel.text = user.username;
        cell.headerUserLabel.text = user.username;
        cell.captionLabel.text = post["caption"] as? String;
        
        let imageFile = post["image"] as! PFFileObject;
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af.setImage(withURL: url);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts();
        }
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
