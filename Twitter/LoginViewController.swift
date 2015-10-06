//
//  ViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 9/27/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject) {
        User.loginWithCompletion({ () -> Void in
            // logged in
        })
    }
}

