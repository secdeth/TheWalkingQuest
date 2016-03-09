//
//  StartGameViewController.swift
//  TheWalkingQuest
//
//  Created by will weathers on 3/2/16.
//  Copyright © 2016 Will Weathers. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var playerGems: Int = 0
    var spentGems = 0
    var playerHealth = 0
    var loaded = false
    
    override func viewDidLoad() {
        defaults.setInteger(100, forKey: "playerHealth")
        defaults.setInteger(0, forKey: "gems")
        defaults.setInteger(0, forKey: "spentGems")
        defaults.setValue(true, forKey: "loaded")
        
        self.restorationIdentifier = "StartGameViewController"
    }
    
    
    @IBAction func startGame(sender: AnyObject) {
        
        let segueView = self.storyboard?.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
        self.presentViewController(segueView, animated: true , completion: nil )
            
        }
        
}
    
    
