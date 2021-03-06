//
//  User.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/29/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    /*func loginCompletion(completion: () -> Void) {
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if (user != nil) {
                // println("my login worked")
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLoginNotification, object: nil))
                completion()
            } else {
                println("error logging in")
            }
        }

    }*/
    
    class func loginWithCompletion(completion: () -> Void) {
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
            if (user != nil) {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLoginNotification, object: nil))
                completion()
            } else {
                println("error logging in")
            }
        }
    }

    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                  var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                  _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
