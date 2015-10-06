//
//  TwitterClient.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/27/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

let twitterConsumerKey = "3JJEBZUjh5polfD69sstSOHd1"
let twitterConsumerSecret = "NXM4J5Yiy8WwMyERTbiEgX6Qlx4OEqWvqitGJjqUrHa3V1IYpi"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
   
    func homeTimelineWithParams (params: NSDictionary?, completion: (tweets:[Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("==========Status=======\n\(response)")
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            println("$$$$$$$$$$$$$$$")
            println(response)
            /*for tweet in tweets {
                println("Text: \(tweet.text), Created at \(tweet.createdAt)")
            }*/
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error in fetching status")
                completion(tweets: nil, error: error)
        })
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
     loginCompletion = completion
    
    // Fetch request token and redirect to autherization page
      TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
      TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope:
            nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
                println("Got request token")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                println("Failure in request toke")
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "Post", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
          println("Got access token")
          TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
          TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("==========User=======\n:\(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                //println("user \(user.name)")
            self.loginCompletion!(user: user, error: nil)
            
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error Getting current user")
                    self.loginCompletion!(user:nil, error: error)
        })
            
            }) { (error: NSError!) -> Void in
                println("Failure in getting access token")
                 self.loginCompletion!(user:nil, error: error)
        }
    }
}
