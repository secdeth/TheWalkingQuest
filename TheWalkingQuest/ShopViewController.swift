//
//  ShopViewController.swift
//  TheWalkingQuest
//
//  Created by will weathers on 2/24/16.
//  Copyright © 2016 Will Weathers. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var playerHealth = 0
    var playerGems: Int = 0
    var spentGems = 0
    
    
    @IBOutlet weak var shopView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        playerHealth = (defaults.valueForKey("playerHealth") as? Int)!
        playerGems = (defaults.integerForKey("gems") as? Int)!
        spentGems = (defaults.valueForKey("spentGems") as? Int)!
        
    }
    
    @IBAction func healthPotion(sender: AnyObject) {
        if  playerHealth <= 100 {
            if (playerGems - spentGems) > 0 {
                playerGems -= 1
                playerHealth += 20
                spentGems += 1
                shopView.text = String("You were healed by 20. Your health is now \(playerHealth)")
                defaults.setInteger(playerHealth, forKey: "playerHealth")
                defaults.setInteger(spentGems, forKey: "spentGems")
                defaults.setInteger(playerGems, forKey: "gems")
            }
        } else {
            shopView.text = String("You are to healthy to heal come back when you've taken more damage.")
        }
    }
 
    @IBAction func revive(sender: AnyObject) {
        if playerHealth >= 0 {
            if (playerGems - spentGems) > 0 {
                playerGems -= 5
                playerHealth += 75
                shopView.text = String("You were brought back from the dead. Your health is now \(playerHealth)")
                defaults.setInteger(playerHealth, forKey: "playerHealth")
                defaults.setInteger(spentGems, forKey: "spentGems")
                defaults.setInteger(playerGems, forKey: "gems")
            }
        
        } else {
            shopView.text = String("Use this when you die for a fresh start.")
        }
    }
    

}