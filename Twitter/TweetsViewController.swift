//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/30/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets:[Tweet]?

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            println("Tweets :\(self.tweets)")
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
