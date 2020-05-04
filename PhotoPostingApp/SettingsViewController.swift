//
//  SettingsViewController.swift
//  PhotoPostingApp
//
//  Created by Lauren Banawa on 5/4/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toViewController", sender: nil)
        
    }
    

}
