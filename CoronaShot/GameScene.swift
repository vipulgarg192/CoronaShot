//
//  GameScene.swift
//  ZombieGame
//
//  Created by vipul garg on 2020-06-08.
//  Copyright © 2020 VipulGarg. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let projectile: UInt32 = 0b10      // 2
}


class GameScene: SKScene {

    
    var heroNode: SKSpriteNode?
    let velocityMultiplier: CGFloat = 0.12
    let joystick = TLAnalogJoystick(withDiameter: 200)
    
    var background = SKSpriteNode(imageNamed:"ingamebg")
    var hero = SKSpriteNode(imageNamed:"doc1")
    var heroBackground = SKSpriteNode(imageNamed:"zebracross")

    let covidP = SKSpriteNode(imageNamed:"covidP1")
    let doctorAnimation: SKAction
    let patient1Animation : SKAction
    let projectile = SKSpriteNode(imageNamed: "injection")
    
    var healthbattery = SKSpriteNode(imageNamed:"healthbattery")
    
    var healthdot1 = SKSpriteNode(imageNamed:"healthdot")
    var healthdot2 = SKSpriteNode(imageNamed:"healthdot")
    var healthdot3 = SKSpriteNode(imageNamed:"healthdot")
    
    let playableRect: CGRect
//    let backgroundMusic: SKAction = SKAction.playSoundFileNamed(
//      "caronashot.mp3", waitForCompletion: false)
    let hitMusic: SKAction = SKAction.playSoundFileNamed(
      "hitCatLady.wav", waitForCompletion: false)
    
    var backgroundMusic: SKAudioNode!
    
    override init(size: CGSize) {
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // it's face down
            print("Iphone")
        } else {
                 print("Ipad")
        }
        
       let maxAspectRatio:CGFloat = 16.0/9.0 // 1
       let playableHeight = size.width / maxAspectRatio // 2
       let playableMargin = (size.height-playableHeight)/2.0 // 3
       playableRect = CGRect(x: 0, y: playableMargin,
       width: size.width,
       height: playableHeight)
        
//       print(playableHeight)
//       print(playableMargin)
        
        print(playableRect.minX)
        print(playableRect.maxX)
   
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
         timePerFrame: 0.16)
        
        patient1Animation = SKAction.animate(with: patient1textures,
        timePerFrame: 0.16)
         super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(playableRect)
        shape.path = path
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
       }
    
    
    override func didMove(to view: SKView) {
//        run(hitMusic)
//         playBackgroundMusic(filename: "caronashot.mp3")
//        self.view?.scene?.size = CGSize(width: 2048, height: 852)
//        view.scaleMode =  .aspectFill
        backgroundColor = SKColor.red
        joystick.position = CGPoint(x: 674, y: 274)
        addChild(joystick)
        if let musicURL = Bundle.main.url(forResource: "caronashot", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }else{
            print("no music")
        }
//        working
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        backgroundColor = SKColor.white
        // this is to bring the background into center
//        background.position =   CGPoint(x: size.width/2, y: size.height/2)
//        background.zPosition = -1
//        addChild(background)
        
          
        
        createBackground()
        
        heroBackground.position =   CGPoint(x: hero.size.width, y: size.height/2)
        heroBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        heroBackground.zPosition = 1
        heroBackground.setScale(0.90)
        addChild(heroBackground)
        
        
        
        healthbattery.position =   CGPoint(x: hero.size.width/4, y: size.height/2)
        healthbattery.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        healthbattery.zPosition = 1
        healthbattery.setScale(0.90)
        addChild(healthbattery)
        
        
        healthdot2.position =   CGPoint(x: hero.size.width/4, y: size.height/2)
        healthdot2.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        healthdot2.zPosition = 2
        healthdot2.setScale(0.90)
        addChild(healthdot2)
        
//        healthdot2.position =   CGPoint(x: hero.size.width/4, y: size.height/1.5)
//        healthdot2.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
//        healthdot2.zPosition = 1
//        healthdot2.setScale(0.90)
//        addChild(healthdot2)
//
                healthdot1.position =   CGPoint(x: hero.size.width/4, y: size.height/1.6)
                healthdot1.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
                healthdot1.zPosition = 2
                healthdot1.setScale(0.90)
                addChild(healthdot1)
        
        healthdot3.position =   CGPoint(x: hero.size.width/4, y: size.height/2.6)
        healthdot3.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        healthdot3.zPosition = 2
        healthdot3.setScale(0.90)
        addChild(healthdot3)
        

        hero.position =   CGPoint(x: hero.size.width, y: size.height/2)
        hero.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        hero.setScale(0.6)
        hero.zPosition = 100
        addChild(hero)
        heroNode = hero
        hero.run(SKAction.repeatForever(doctorAnimation))
        
                
          run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(spawnEnemy),
            SKAction.wait(forDuration: 7.0)
            ])
        ))
        
        run(SKAction.repeatForever(
                 SKAction.sequence([
                   SKAction.run(spawnCovidP),
                   SKAction.wait(forDuration: 2.0)
                   ])
               ))
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        debugDrawPlayableArea()
        
        joystick.on(.move) { [unowned self] joystick in
            guard var heroNode = self.heroNode else {
                return
            }
            
            let bottomLeft = CGPoint(x: 0, y: self.playableRect.minY)
            let topRight = CGPoint(x: self.playableRect.maxX, y: self.playableRect.maxY)
            
            let pVelocity = joystick.velocity;
            let speed = CGFloat(0.25)
                       
            if heroNode.position.y <= bottomLeft.y + heroNode.size.height * 0.8 {
                            heroNode.position.y = bottomLeft.y + heroNode.size.height * 0.8
                        }
                        if heroNode.position.y >= topRight.y -   heroNode.size.height * 0.8{
                        heroNode.position.y = topRight.y -   heroNode.size.height * 0.8
                        }
           
                             heroNode.position = CGPoint(x: heroNode.position.x  , y: heroNode.position.y + (pVelocity.y * speed))
                         
            
           
        }
        
        joystick.on(.end) { [unowned self] _ in
            print(self.heroNode!.position)
//            let actions = [
//                SKAction.scale(to: 1.5, duration: 0.5),
//                SKAction.scale(to: 1, duration: 0.5)
//            ]
//
//            self.heroNode?.run(SKAction.sequence(actions))
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                   let location = touch.location(in: self)
            
            print(location)
//          movePlayer(loc : location)
//          shotter(location: location)
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
          return
        }
        let touchLocation = touch.location(in: self)
        
        // 2 - Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "injection")
        projectile.position = CGPoint(x: hero.position.x + hero.position.x/2.4, y: hero.position.y)
        
        // 3 - Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        
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
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
        projectile.physicsBody?.usesPreciseCollisionDetection = true
       
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
                   let backgroundTexture = SKTexture(imageNamed: "ingamebg")

                   for i in 0 ... 1{
                       let background = SKSpriteNode(texture: backgroundTexture)
                       background.zPosition = -1
                    background.size = CGSize(width: self.frame.size.width * 1.1 , height: self.frame.size.height * 0.9 )
                       background.anchorPoint = CGPoint(x: 0, y: 0.5)
                       background.position = CGPoint(x:  (backgroundTexture.size().width * CGFloat(i)) , y: size.height/2)
                     let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 10)
                     let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
                     let moveLoop = SKAction.sequence([moveLeft, moveReset])
                     let moveForever = SKAction.repeatForever(moveLoop)
                     background.run(moveForever)
                     addChild(background)
                   }
         }
    
//     func createBackground() {
//        let backgroundTexture = SKTexture(imageNamed: "ingamebg")
//
//
//
//
//              for i in 0 ... 1{
//
//                let background = SKSpriteNode(texture: backgroundTexture)
//                              background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//                              background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height * 0.9 )
//                              background.zPosition = -1
////                                    self.addChild(background)
//
////                  let background = SKSpriteNode(texture: backgroundTexture)
////                  background.zPosition = -1
////                  background.anchorPoint = CGPoint(x: 0, y: 0.5)
////                  background.position = CGPoint(x:  (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: size.height/2)
//                let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 10)
//                let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
//                let moveLoop = SKAction.sequence([moveLeft, moveReset])
//                let moveForever = SKAction.repeatForever(moveLoop)
////                background.size = UIScreen.main.bounds.size
//
//                background.run(moveForever)
//                addChild(background)
//              }
//    }
    
    func spawnEnemy() {
        
        let ppNO = CGFloat.random(min: 1, max: 7)
        let virus = SKSpriteNode(imageNamed: "pp\(ppNO)")
        let actualY = CGFloat.random(min: virus.size.height/2, max: size.height - virus.size.height/2)
        virus.position = CGPoint(x: size.width + virus.size.width/2, y: actualY)
        virus.setScale(0.5)
        virus.zPosition = 2
        addChild(virus)
        let actionMove = SKAction.move(to: CGPoint(x: -virus.size.width/2, y: actualY),
                                       duration: TimeInterval(3))
        let actionMoveDone = SKAction.removeFromParent()
        virus.run( SKAction.sequence([actionMove, actionMoveDone]))
    }
    
      func spawnCovidP() {
            let covidP1 = SKSpriteNode(imageNamed: "covidP1")
//        let actualY = CGFloat.random(min: self.playableRect.minX, max:  covidP1.size.height + 1)
        let actualY = CGFloat.random(min: self.playableRect.minY + covidP1.size.height * 1.2 , max:  self.playableRect.maxY - covidP1.size.height )
            covidP1.position = CGPoint(x: size.width + covidP1.size.width/2, y: actualY)
            covidP1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            covidP1.setScale(0.6)
        covidP1.zPosition = 3
            addChild(covidP1)
            covidP1.run(SKAction.repeatForever(patient1Animation))
        
            let actionMove = SKAction.move(to: CGPoint(x: -covidP1.size.width/2, y: actualY),
                                           duration: TimeInterval(4))
            let actionMoveDone = SKAction.removeFromParent()
            covidP1.run( SKAction.sequence([actionMove, actionMoveDone]))
        
        
        covidP1.physicsBody = SKPhysicsBody(rectangleOf: covidP1.size) // 1
        covidP1.physicsBody?.isDynamic = true // 2
        covidP1.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        covidP1.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
        covidP1.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        }

    func movePlayer(loc : CGPoint){
         let offset = CGPoint(x: loc.x - hero.position.x,
                         y: loc.y - hero.position.y)
         let length = sqrt(
                            Double(offset.x * offset.x + offset.y * offset.y))
        let time = length/480
           let actionMove = SKAction.move(
               to: CGPoint(x: hero.size.width, y: loc.y),
                    duration: time)
                   hero.run(actionMove)
       }
    
    func shotter(location: CGPoint) {
      // 2 - Set up initial location of projectile
         projectile.position = hero.position
         
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
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
      projectile.removeFromParent()
      monster.removeFromParent()
    }


}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
      // 1
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA
        secondBody = contact.bodyB
      } else {
        firstBody = contact.bodyB
        secondBody = contact.bodyA
      }
     
      // 2
      if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
          (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
        if let monster = firstBody.node as? SKSpriteNode,
          let projectile = secondBody.node as? SKSpriteNode {
          projectileDidCollideWithMonster(projectile: projectile, monster: monster)
        }
      }
    }
}
