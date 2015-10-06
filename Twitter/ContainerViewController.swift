//
//  ContainerViewController.swift
//  Twitter
//
//  Created by Rajiv Bammi on 10/5/15.
//  Copyright (c) 2015 Rajiv B. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    // Views for left/content
    @IBOutlet weak var leftPanelView: UIView!
    @IBOutlet weak var contentPanelView: UIView!
    
    // Controllers 
    var sideViewController: SidebarTableViewController!
    var loginViewController: LoginViewController!
    var contentViewController: UINavigationController!
    var profileController: UITableViewController!
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogin", name: userDidLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogout", name: userDidLogoutNotification, object: nil)
        
        // Setting left menu
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        sideViewController = storyboard.instantiateViewControllerWithIdentifier("SidebarTableViewController") as! SidebarTableViewController
        
        addViewControllers(sideViewController, destView: leftPanelView)
        
        if (User.currentUser != nil) {
            contentViewController = storyboard.instantiateViewControllerWithIdentifier("TweetNagivationController") as! UINavigationController
            addViewControllers(contentViewController, destView: contentPanelView)
        } else {
          self.loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
          addViewControllers(self.loginViewController, destView: contentPanelView)
        }
        self.view.bringSubviewToFront(self.contentPanelView)
    }
    
    func addViewControllers (viewController: UIViewController, destView: UIView) {
        self.addChildViewController(viewController)
        destView.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        viewController.didMoveToParentViewController(self)
    }

    @IBAction func onPanGuesture(sender: AnyObject) {
        print("Inside guesture")
        var currentLocation = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(currentLocation)")
            var quarter = self.view.frame.width / 4
            if (currentLocation.x <= (quarter * 3)) {
                self.contentPanelView.frame.origin.x = currentLocation.x
            }
        } else if sender.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(currentLocation)")
            var quarter = self.view.frame.width / 4
            if (currentLocation.x <= (quarter * 3)) {
                self.contentPanelView.frame.origin.x = currentLocation.x
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(currentLocation)")
            var center = self.view.center
            if (currentLocation.x < center.x) {
                self.contentPanelView.frame.origin.x = 0;
            } else {
                var quarter = self.view.frame.width / 4
                self.contentPanelView.frame.origin.x = (quarter * 3)
            }
            
        }
    }
    
    func userLogin() {
      print("login")
        self.sideViewController.initUI()
        if (self.contentViewController == nil) {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.contentViewController = storyboard.instantiateViewControllerWithIdentifier("TweetNagivationController") as! UINavigationController
            self.addChildViewController(self.contentViewController)
        }
       self.contentPanelView.addSubview(self.contentViewController.view)
       self.contentViewController.view.frame = self.view.frame
       self.contentViewController.didMoveToParentViewController(self)
        
    }
    func userLogout() {
    print("logout")
    self.loginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
    addViewControllers(self.loginViewController, destView: contentPanelView)
    }
}
