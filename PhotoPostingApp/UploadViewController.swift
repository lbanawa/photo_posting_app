//
//  UploadViewController.swift
//  PhotoPostingApp
//
//  Created by Lauren Banawa on 5/4/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionText: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tap image to upload from photo library
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    // when user chooses image from photo library,
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    @IBAction func postButtonClicked(_ sender: Any) {
        // Storage supports uploading and downloading objects -- use to upload photos
        let storage = Storage.storage() // create storage instance
        let storageReference = storage.reference() // create storage reference
     
        // .child means going one level below -- .child(name of folder in firebase Storage)
        // if you add another .child after the first, it will create another folder within the first folder
        let photosFolder = storageReference.child("photos")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            // create a unique id for each picture
            let uuid = UUID().uuidString
            
            let imageReference = photosFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageURL = url?.absoluteString
                            
                            // store our information to Firestore Database
                            let firestoreDatabase = Firestore.firestore() // instance of the firestore class -- can be used to download and upload data
                            
                            // DocumentReference refers to a document location in the database and can be used to read, write, or listen to the location
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageURL" : imageURL!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.captionText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            // .collection refers to the collection at a specified path in the database
                            // .addDocument adds documents to the collection with an automatically assigned document ID
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                    
                                } else {
                                    
                                    self.imageView.image = UIImage(named: "selectimage1.png")
                                    self.captionText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                        }
                    }
                    
                }
            }
            
        }
        
    }
    

}
