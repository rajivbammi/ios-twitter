//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/30/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets:[Tweet]?

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogout(sender: AnyObject) {
        print("logging out user")
        User.currentUser?.logout()
    }
   
    override func viewDidLoad() {
        print("Calling reload")
        super.viewDidLoad()
       
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            //println("Tweets :\(self.tweets)")
            self.tableView.reloadData()
        })
      
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            //println(self.tweets!.count)
            return self.tweets!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet =  self.tweets![indexPath.row]
        cell.tweetTextLabel!.text = tweet.text
        cell.nameLabel.text =
            tweet.user?.name
        cell.accountLabel.text = tweet.user?.screenname
        let url = NSURL(string: tweet.user?.profileImageUrl as String!)
        cell.tweetImage.setImageWithURL(url!)
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "TweetDetailControllerSegue" {
        print("TweetDetailControllerSegue")
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPathForCell(cell) {
            let detailController = segue.destinationViewController as! TweetDetailsViewController
            detailController.tweet = self.tweets![indexPath.row]
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
      } else if segue.identifier == "ComposeControllerSegue" {
        print("ComposeControllerSegue")
        }
    }
}
