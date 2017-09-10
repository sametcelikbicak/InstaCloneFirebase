//
//  FirstViewController.swift
//  InstaCloneFirebase
//
//  Created by Samet ÇELİKBIÇAK on 9.09.2017.
//  Copyright © 2017 Samet ÇELİKBIÇAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var useremailArray = [String]()
    var postImageURLArray = [String]()
    var postCommentArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromServer()
        
    }
    
    func getDataFromServer() {
        
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            
            let post = values["post"] as! NSDictionary
            
            let postIDs = post.allKeys
            
            for id in postIDs {
                let singlePost = post[id] as! NSDictionary
                self.useremailArray.append(singlePost["postedby"] as! String)
                self.postCommentArray.append(singlePost["posttext"] as! String)
                self.postImageURLArray.append(singlePost["image"] as! String)
            }
            self.tableView.reloadData()
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.postText.text = postCommentArray[indexPath.row]
        cell.usernameLabel.text = useremailArray[indexPath.row]
        cell.postImage.sd_setImage(with: URL(string: self.postImageURLArray[indexPath.row]))
        
        return cell
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signIn
        delegate.rememberLogin()
        
        
    }
    
}

