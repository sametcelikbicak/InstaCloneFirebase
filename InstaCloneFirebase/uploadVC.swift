//
//  SecondViewController.swift
//  InstaCloneFirebase
//
//  Created by Samet ÇELİKBIÇAK on 9.09.2017.
//  Copyright © 2017 Samet ÇELİKBIÇAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class uploadVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextView!
    var uuid = NSUUID().uuidString
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        postImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        postImage.addGestureRecognizer(recognizer)
        
    }

    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        postImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func postButtonClicked(_ sender: Any) {
        
        let mediaFolder = Storage.storage().reference().child("media")
        
        if let data = UIImageJPEGRepresentation(postImage.image!, 0.5) {
            
            mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let imageURL = metadata?.downloadURL()?.absoluteString
                    
                    let post = ["image" : imageURL!, "postedby" : Auth.auth().currentUser!.email!, "uuid" : self.uuid, "posttext" : self.postComment.text] as [String : Any]
                    
                    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                    
                    self.postImage.image = UIImage(named : "select.png")
                    self.postComment.text = ""
                    self.tabBarController?.selectedIndex = 0
                }
                
            })
            
        }
        
    }
    
}

