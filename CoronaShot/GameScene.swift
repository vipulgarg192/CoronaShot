//
//  GameScene.swift
//  ZombieGame
//
//  Created by vipul garg on 2020-06-08.
//  Copyright © 2020 VipulGarg. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    
   var background = SKSpriteNode(imageNamed:"background1")
   let nurse = SKSpriteNode(imageNamed:"doc1")
   let covidP = SKSpriteNode(imageNamed:"covidP1")
   let doctorAnimation: SKAction
   let patient1Animation : SKAction
    
    override init(size: CGSize) {
        var textures:[SKTexture] = []
        var patient1textures:[SKTexture] = []
        // 2
        for i in 1...8 {
         textures.append(SKTexture(imageNamed: "doc\(i)"))
         patient1textures.append(SKTexture(imageNamed: "covidP\(i)"))
        }
        // 3
          
        textures.append(textures[7])
        textures.append(textures[6])
        textures.append(textures[5])
        textures.append(textures[4])
        textures.append(textures[3])
        textures.append(textures[2])
        textures.append(textures[1])
        
             patient1textures.append(patient1textures[7])
             patient1textures.append(patient1textures[6])
             patient1textures.append(patient1textures[5])
             patient1textures.append(patient1textures[4])
             patient1textures.append(patient1textures[3])
             patient1textures.append(patient1textures[2])
             patient1textures.append(patient1textures[1])
        // 4
        doctorAnimation = SKAction.animate(with: textures,
         timePerFrame: 0.1)
        
        patient1Animation = SKAction.animate(with: patient1textures,
        timePerFrame: 0.1)
         super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        // working
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        backgroundColor = SKColor.white
        // this is to bring the background into center
        background.position =   CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
//        addChild(background)
//        createBackground()

        nurse.position =   CGPoint(x: nurse.size.width/2, y: size.height/2)
        nurse.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        addChild(nurse)
        nurse.run(SKAction.repeatForever(doctorAnimation))
        
        
        
        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(spawnEnemy),
            SKAction.wait(forDuration: 1.0)
            ])
        ))
        
        run(SKAction.repeatForever(
                 SKAction.sequence([
                   SKAction.run(spawnCovidP),
                   SKAction.wait(forDuration: 1.0)
                   ])
               ))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                   let location = touch.location(in: self)

                   movePlayer(loc : location)
            shotter(location: location)
               }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func update(_ currentTime: TimeInterval) {

        
    }
    
    override func didEvaluateActions() {
    
    }
    
    override func didSimulatePhysics() {
    
    }
    
    override func didApplyConstraints() {
        
    }
    
    
     func createBackground() {
              let backgroundTexture = SKTexture(imageNamed: "bg1")

              for i in 0 ... 1{
                  let background = SKSpriteNode(texture: backgroundTexture)
                  background.zPosition = -1
                  background.anchorPoint = CGPoint(x: 0, y: 0.5)
                  background.position = CGPoint(x:  (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: size.height/2)
                let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 10)
                let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
                let moveLoop = SKAction.sequence([moveLeft, moveReset])
                let moveForever = SKAction.repeatForever(moveLoop)
                background.size = UIScreen.main.bounds.size

                background.run(moveForever)
                addChild(background)
              }
    }
    
    func spawnEnemy() {
        
        let virusNo = CGFloat.random(min: 1, max: 7)
        
        let enemy = SKSpriteNode(imageNamed: "virus\(virusNo)")
//        let enemy = SKSpriteNode(imageNamed: "virus6")

        
         let actualY = CGFloat.random(min: enemy.size.height/2, max: size.height - enemy.size.height/2)
        
        
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
       enemy.position = CGPoint(x: size.width + enemy.size.width/2, y: actualY)
        addChild(enemy)
        
//        let actualDuration = CGFloat.random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: -enemy.size.width/2, y: actualY),
                                       duration: TimeInterval(4))
        let actionMoveDone = SKAction.removeFromParent()
        enemy.run( SKAction.sequence([actionMove, actionMoveDone]))

        
    }
    
      func spawnCovidP() {
            let covidP1 = SKSpriteNode(imageNamed: "covidP1")
            let actualY = CGFloat.random(min: covidP1.size.height/2, max: size.height - covidP1.size.height/2)
            covidP1.position = CGPoint(x: size.width + covidP1.size.width/2, y: actualY)
            addChild(covidP1)
            covidP1.run(SKAction.repeatForever(patient1Animation))
            let actionMove = SKAction.move(to: CGPoint(x: -covidP1.size.width/2, y: actualY),
                                           duration: TimeInterval(4))
            let actionMoveDone = SKAction.removeFromParent()
            covidP1.run( SKAction.sequence([actionMove, actionMoveDone]))
        }

    func movePlayer(loc : CGPoint){
         let offset = CGPoint(x: loc.x - nurse.position.x,
                         y: loc.y - nurse.position.y)
         let length = sqrt(
                            Double(offset.x * offset.x + offset.y * offset.y))
        let time = length/480
           let actionMove = SKAction.move(
               to: CGPoint(x: nurse.size.width/4, y: loc.y),
                    duration: time)
                   nurse.run(actionMove)
       }
    
    func shotter(location: CGPoint) {
      // 2 - Set up initial location of projectile
         let projectile = SKSpriteNode(imageNamed: "virus6")
         projectile.position = nurse.position
         
         // 3 - Determine offset of location to projectile
         let offset = location - projectile.position
         
         // 4 - Bail out if you are shooting down or backwards
         if offset.x < 0 { return }
         
         // 5 - OK to add now - you've double checked position
         addChild(projectile)
         
         // 6 - Get the direction of where to shoot
         let direction = offset.normalized()
         
         // 7 - Make it shoot far enough to be guaranteed off screen
         let shootAmount = direction * 2000
         
         // 8 - Add the shoot amount to the current position
         let realDest = shootAmount + projectile.position
         
         // 9 - Create the actions
        let actionMove = SKAction.move(to: realDest, duration: 1.5)
         let actionMoveDone = SKAction.removeFromParent()
         projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}

