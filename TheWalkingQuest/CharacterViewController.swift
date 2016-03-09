//
//  CharacterViewController.swift
//  TheWalkingQuest
//
//  Created by will weathers on 2/22/16.
//  Copyright © 2016 Will Weathers. All rights reserved.
//

import UIKit
import CoreMotion
import Social

class CharacterViewController: UIViewController {

    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var gemsLabel: UILabel!
    @IBOutlet weak var stepsLeftLabel: UILabel!
    @IBOutlet weak var stepProgress: UIProgressView!
    @IBOutlet weak var weaponLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let pedometer = CMPedometer()
    var data: CMPedometerData?
    
    var playerGems: Int = 0
    var spentGems = 0
    var playerHealth = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if CMPedometer.isStepCountingAvailable() {
            
            pedometer.startPedometerUpdatesFromDate(NSCalendar.currentCalendar().startOfDayForDate(NSDate())) { (data, error) -> Void in
                if error != nil {
                    print("Can not load the data  \(error)")
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let totalSteps = Int(floor((data?.numberOfSteps.floatValue)!))
                        
                        self.playerGems = Int(totalSteps / 100)
                        self.gemsLabel.text = String(self.playerGems - self.spentGems)
                        self.stepsLeftLabel.text = String(100 - ((data?.numberOfSteps.integerValue)! % 100))
                        self.stepProgress.progress = ((data?.numberOfSteps.floatValue)! % 100) / 100
                        
                        self.defaults.setInteger(self.playerGems, forKey: "gems")
                        
                    })
                    
                }
                
            }
        } else {
            print("Step counting not available on this device.")
        }
        
    
        self.restorationIdentifier = "CharacterViewController"
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if defaults.boolForKey("loaded") == false {
            let segueView = self.storyboard!.instantiateViewControllerWithIdentifier("StartGameViewController")
            self.presentViewController(segueView, animated: true , completion: nil )
        }
        
        if let playerHealth = defaults.stringForKey("playerHealth"){
            healthLabel.text = playerHealth
        }
        
        if let playerGems = defaults.stringForKey("gems"){
            gemsLabel.text = String(Int(playerGems)! - spentGems)
        }
        
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func tweetButton(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            self.presentViewController(tweetShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }

        
    }
    
    
    
}