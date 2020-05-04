//
//  ViewController.swift
//  PhotoPostingApp
//
//  Created by Lauren Banawa on 5/3/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            // Auth manages authentication for Firebase apps
            // create user with email and password
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                
                // This is a closure -- in closures we have to add "self."
                if error != nil {
                    // display error message from Firebase -- provide default value if error is nil/ something else is wrong so it does not crash
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Please enter email and password!")
        }
        
        
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        
        // create alert with title and message
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        // button for user to dismiss alert
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton) // add the alert action to the alert
        self.present(alert, animated: true, completion: nil) // present the alert
        
    }
    
    
}

