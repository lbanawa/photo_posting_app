//
//  SettingsViewController.swift
//  PhotoPostingApp
//
//  Created by Lauren Banawa on 5/4/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("error")
        }
        
    }
    

}
