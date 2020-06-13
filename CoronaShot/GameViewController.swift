//
//  GameViewController.swift
//  CoronaShot
//
//  Created by vipul garg on 2020-06-11.
//  Copyright © 2020 VipulGarg. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
           let scene =
            GameScene(size:CGSize(width: 2048, height: 1152))
            let skView = self.view as! SKView
            skView.showsFPS = true
//            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
