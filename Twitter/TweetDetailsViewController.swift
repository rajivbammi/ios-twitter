//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 10/2/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameText: UILabel!
    
    @IBOutlet weak var screenNameText: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        println("inside")
        print(tweet?.text)
    
    self.tweetText.text = tweet!.text
    self.userNameText.text = tweet!.user?.name
    self.screenNameText.text = tweet!.user?.screenname
    let url = NSURL(string: tweet!.user?.profileImageUrl as String!)
    self.profileImage.setImageWithURL(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
