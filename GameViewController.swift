//
//  GameViewController.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 8/28/15.
//  Copyright (c) 2015 Laser Studio. All rights reserved.
//

import UIKit
import SpriteKit
//import GoogleMobileAds

class GameViewController: UIViewController {
    
    // var interstitial: GADInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = HomeScene(fileNamed:"HomeScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFit
            
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            // return .AllButUpsideDown
            return .portrait
        } else {
            // return .All
            return .portrait
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
