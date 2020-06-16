//
//  MainMenuScene.swift
//  CoronaShot
//
//  Created by vipul garg on 2020-06-16.
//  Copyright © 2020 VipulGarg. All rights reserved.
//


import Foundation
import SpriteKit

class MainMenuScene: SKScene {
 
  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "fight")
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(background)
  }
  
  func sceneTapped() {
    let myScene = GameScene(size: size)
    myScene.scaleMode = scaleMode
    let reveal = SKTransition.doorway(withDuration: 1.5)
    view?.presentScene(myScene, transition: reveal)
  }

  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    sceneTapped()
  }

}
