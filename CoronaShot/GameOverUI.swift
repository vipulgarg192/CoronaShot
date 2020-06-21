//
//  GameOverUI.swift
//  CoronaShot
//
//  Created by vipul garg on 2020-06-21.
//  Copyright © 2020 VipulGarg. All rights reserved.
//


import Foundation
import SpriteKit
class GameOverUI: SKScene {
    let won:Bool
init(size: CGSize, won: Bool) {
self.won = won
super.init(size: size)
}
required init(coder aDecoder: NSCoder) {
fatalError("init(coder:) has not been implemented")
}
    
    override func didMove(to view: SKView) {
var background: SKSpriteNode
if (won) {
background = SKSpriteNode(imageNamed: "victory")
} else
{
    background = SKSpriteNode(imageNamed: "lost")
        }
background.position =
CGPoint(x: size.width/2, y: size.height/2)
self.addChild(background)
        
let wait = SKAction.wait(forDuration: 3.0)
let block = SKAction.run {
let myScene = GameScene(size: self.size)
    
myScene.scaleMode = self.scaleMode
let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
self.view?.presentScene(myScene, transition: reveal)
}
self.run(SKAction.sequence([wait, block]))
}
}

