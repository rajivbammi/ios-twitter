//
//  Tweet.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/29/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorite_count: String?
    var retweet_count: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["createdAt"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString ?? "")
        
        favorite_count = dictionary["favorite_count"] as? String
        retweet_count = dictionary["retweet_count"] as? String
        //println("Value")
        //var user1 = dictionary["user"] as! NSDictionary
        
        //println(user1["profile_image_url"])
    }

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
