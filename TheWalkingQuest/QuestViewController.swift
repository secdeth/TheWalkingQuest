//
//  QuestViewController.swift
//  TheWalkingQuest
//
//  Created by will weathers on 2/24/16.
//  Copyright © 2016 Will Weathers. All rights reserved.
//

import UIKit

class QuestViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var timeOfQuest = 0
    var timer = NSTimer()
    var onQuest = false
    var playerHealth = 0
    
    @IBOutlet weak var questView: UITextView!
    @IBOutlet weak var exploreCave: UIButton!
    @IBOutlet weak var fightRockGolem: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questView.editable = false
        questView.selectable = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        playerHealth = (defaults.valueForKey("playerHealth") as? Int)!
        
    }
    
    @IBAction func exploreCave(sender: AnyObject) {
    
        if playerHealth > 0 {
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "exploreCaveStats", userInfo: nil, repeats: false)
            onQuest = true
            exploreCave.enabled = false
            
            
        } else {
            questView.text = String("You are dead, try again when you are not a ghost.")
        }
        
    }
    
    @IBAction func fightRockGolem(sender: AnyObject) {
        
        if playerHealth > 0 {
            timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "fightRockGolemStats", userInfo: nil, repeats: false)
            onQuest = true
            fightRockGolem.enabled = false
            
        } else {
            questView.text = String("A zombie would have no chance against a Rock Golem. Come back when you're less undead.")
        }
        
    }
    
    func exploreCaveStats() {
        if onQuest == true {
            if playerHealth > 0 {
                playerHealth = playerHealth - Int(arc4random_uniform(15))
                questView.text = String("You fought a scary rat. Your health is now \(playerHealth)")
                onQuest = false
                exploreCave.enabled = true
                
                defaults.setInteger(playerHealth, forKey: "playerHealth")
                
            }
            
        }

    }
    
    func fightRockGolemStats() {
        if onQuest == true {
            if playerHealth > 40 {
                playerHealth = playerHealth - Int(arc4random_uniform(40))
                questView.text = String("You slayed the Rock Golem but not without some damage. \nYour health is now \(String(playerHealth))")
                onQuest = false
                fightRockGolem.enabled = true
                
                defaults.setInteger(playerHealth, forKey: "playerHealth")
            }
        }
    }
    
    
}