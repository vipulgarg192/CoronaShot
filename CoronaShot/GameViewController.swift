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
         // for tab height 1536
       let scene =
        MainMenuScene(size:CGSize(width: 2048, height: 1052))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }

}
