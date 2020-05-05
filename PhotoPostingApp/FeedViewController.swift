//
//  FeedViewController.swift
//  PhotoPostingApp
//
//  Created by Lauren Banawa on 5/4/20.
//  Copyright © 2020 Lauren Banawa. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // connect prototype cell to TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.usernameLabel.text = "test@test.com"
        cell.likeLabel.text = "0"
        cell.captionLabel.text = "caption"
        cell.userImageView.image = UIImage(named: "selectimage1.png")
        return cell
    }
    

}
