//
//  SidebarTableViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 10/5/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class SidebarTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
     }
    
    func initUI() {
      if (User.currentUser != nil) {
        var user = User.currentUser
        self.nameLabel.text = user!.name
        var screename = user?.screenname as String!
        self.screenNameLabel.text = "@\(screename)"
        let url = NSURL(string: user?.profileImageUrl as String!)
        self.profileImageView.setImageWithURL(url)
      }
    }

    
    @IBAction func onTimelineBtn(sender: AnyObject) {
        print("clickedtimeline")
    }
    
    @IBAction func onProfileBtn(sender: AnyObject) {
        print("clicked profile")
    }
    
    @IBAction func onSignoutBtn(sender: AnyObject){
    User.currentUser?.logout()
    }
    
    @IBAction func onMentionBtn(sender: AnyObject) {
        print("on mention")
    }
    
}
