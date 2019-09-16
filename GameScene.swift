//
//  GameScene.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 8/28/15.
//  Copyright (c) 2015 Laser Studio. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, UIAccelerometerDelegate, SKPhysicsContactDelegate {
    
    var buttonPressed: SKSpriteNode?
    var powerfulBulletButton = SKSpriteNode()
    
    var powerfulBulletEnabled = true
    
    var score: Int = 0
    
    var maxAccelerometerX: Double = 0
    var maxAccelerometerY: Double = 0
    
    let motionManager = CMMotionManager()
    
    let myPlane = MyPlane()
    
    override func didMove(to view: SKView) {
        self.addScoreLabel()
        // self.addPauseButton()
        self.addPowerfulBulletButton()
        
        self.powerfulBulletButton = self.childNode(withName: "powerfulBullet") as! SKSpriteNode
        
        self.motionManager.accelerometerUpdateInterval = 0.2
        self.motionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {
            (data: CMAccelerometerData?, error) in
            self.updateAccelerationData(data!.acceleration)
        })
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        if IS_DEBUGGING {
            self.score = DEBUGGING_SCORE
        }
        
        self.addMyPlane()
        self.addEnemyPlaneEasy()
        self.addEnemyPlaneMedium()
        self.addEnemyPlaneHard()
    }
    
    func updateAccelerationData(_ acceleration: CMAcceleration) {
        self.maxAccelerometerX = 0
        self.maxAccelerometerY = 0
        if abs(acceleration.x) > abs(self.maxAccelerometerX) {
            self.maxAccelerometerX = acceleration.x
        }
        if abs(acceleration.y) > abs(self.maxAccelerometerY) {
            self.maxAccelerometerY = acceleration.y
        }
    }
    
    func addMyPlane() {
        self.myPlane.position = CGPoint(x: self.size.width / 2, y: self.myPlane.size.height)
        self.addChild(self.myPlane)
    }
    
    func addEnemyPlaneEasy() {
        let addEnemyPlaneEasy = SKAction.run({
            let enemyPlaneEasy = EnemyPlaneEasy()
            let width = enemyPlaneEasy.size.width
            let height = enemyPlaneEasy.size.height
            enemyPlaneEasy.position = CGPoint(x: self.randomNumberBetween(width / 2, max: self.size.width - width / 2), y: self.size.height + height / 2)
            self.addChild(enemyPlaneEasy)
        })
        let wait = SKAction.wait(forDuration: ENEMY_PLANE_EASY_TIME_INTERVAL, withRange: ENEMY_PLANE_EASY_TIME_INTERVAL * 0.8)
        self.run(SKAction.repeatForever(SKAction.sequence([wait, addEnemyPlaneEasy])))
    }
    
    func addEnemyPlaneMedium() {
        let addEnemyPlaneMedium = SKAction.run({
            let enemyPlaneMedium = EnemyPlaneMedium()
            let width = enemyPlaneMedium.size.width
            let height = enemyPlaneMedium.size.height
            enemyPlaneMedium.position = CGPoint(x: self.randomNumberBetween(width / 2, max: self.size.width - width / 2), y: self.size.height + height / 2)
            self.addChild(enemyPlaneMedium)
        })
        let wait = SKAction.wait(forDuration: ENEMY_PLANE_MEDIUM_TIME_INTERVAL, withRange: ENEMY_PLANE_MEDIUM_TIME_INTERVAL * 0.5)
        self.run(SKAction.repeatForever(SKAction.sequence([wait, addEnemyPlaneMedium])))
    }
    
    func addEnemyPlaneHard() {
        let addEnemyPlaneHard = SKAction.run({
            let enemyPlaneHard = EnemyPlaneHard()
            let width = enemyPlaneHard.size.width
            let height = enemyPlaneHard.size.height
            enemyPlaneHard.position = CGPoint(x: self.randomNumberBetween(width / 2, max: self.size.width - width / 2), y: self.size.height + height / 2)
            self.addChild(enemyPlaneHard)
        })
        let wait = SKAction.wait(forDuration: ENEMY_PLANE_HARD_TIME_INTERVAL, withRange: ENEMY_PLANE_HARD_TIME_INTERVAL * 0.5)
        self.run(SKAction.repeatForever(SKAction.sequence([wait, addEnemyPlaneHard])))
    }
    
    func randomNumberBetween(_ min: CGFloat, max: CGFloat) -> CGFloat {
        let range = UInt32(max - min)
        let result = UInt32(min) + arc4random_uniform(range)
        return CGFloat(result)
    }
    
    func addScoreLabel() {
        let labelNode = SKLabelNode(text: "\(SCORE) \(self.score)")
        labelNode.name = "scoreLabel"
        labelNode.fontName = "Menlo-Bold"
        labelNode.fontSize = 20
        labelNode.fontColor = SKColor.black
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .left
        labelNode.position = CGPoint(x: 20, y: self.size.height - 40)
        labelNode.zPosition = Layer.uiComponent
        
        self.addChild(labelNode)
    }
    
    func addPauseButton() {
        let buttonNode = SKSpriteNode(color: UIColor.black, size: CGSize(width: 30, height: 30))
        buttonNode.name = "Pause"
        buttonNode.position = CGPoint(x: self.size.width - 40, y: self.size.height - 40)
        buttonNode.zPosition = Layer.uiComponent
        
        let labelNode = SKLabelNode(text: "||")
        labelNode.name = "labelNode"
        labelNode.fontName = "Menlo-Bold"
        labelNode.fontSize = 15
        labelNode.fontColor = SKColor.white
        labelNode.position = CGPoint(x: 0, y: 0)
        labelNode.verticalAlignmentMode = .center
        
        buttonNode.addChild(labelNode)
        self.addChild(buttonNode)
    }
    
    func addPowerfulBulletButton() {
        let buttonNode = SKSpriteNode(imageNamed: "IconPowerfulBullet")
        buttonNode.name = "powerfulBullet"
        buttonNode.position = CGPoint(x: self.size.width - 40, y: 40)
        buttonNode.zPosition = Layer.uiComponent
        
        self.addChild(buttonNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.containTouches(touches, inNode: self.powerfulBulletButton) {
            self.shouldHighlightNode(true, node: self.powerfulBulletButton)
            self.buttonPressed = self.powerfulBulletButton
        } else {
            let fireBullet = SKAction.run({
                self.myPlane.fireNormalBullet()
            })
            let wait = SKAction.wait(forDuration: MY_BULLET_TIME_INTERVAL)
            let fireMyBullets = SKAction.repeatForever(SKAction.sequence([fireBullet, wait]))
            self.run(fireMyBullets, withKey: "fireMyBullets")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.buttonPressed != nil {
            if !self.containTouches(touches, inNode: self.buttonPressed!) {
                self.shouldHighlightNode(false, node: self.buttonPressed!)
            } else {
                self.shouldHighlightNode(true, node: self.buttonPressed!)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.buttonPressed != nil {
            if self.containTouches(touches, inNode: self.buttonPressed!) {
                self.shouldHighlightNode(false, node: self.buttonPressed!)
                if self.buttonPressed === self.powerfulBulletButton && self.powerfulBulletEnabled {
                    self.powerfulBulletButton.run(SKAction.colorize(withColorBlendFactor: 0.75, duration: 0.1), completion: {
                        self.myPlane.firePowerfulBullet()
                        self.powerfulBulletEnabled = false
                        self.powerfulBulletButton.run(SKAction.colorize(withColorBlendFactor: 0.0, duration: 10), completion: {
                            self.powerfulBulletEnabled = true
                        })
                    })
                }
            }
            self.buttonPressed = nil
        } else {
            self.removeAction(forKey: "fireMyBullets")
        }
        
        if IS_DEBUGGING {
            self.endGame()
        }
    }
    
    func containTouches(_ touches: Set<UITouch>, inNode: SKSpriteNode) -> Bool {
        return touches.contains { touch in
            let touchPoint = touch.location(in: self)
            let touchedNode = self.atPoint(touchPoint)
            return touchedNode === inNode || touchedNode.inParentHierarchy(inNode)
        }
    }
    
    func shouldHighlightNode(_ isHighlighted: Bool, node: SKSpriteNode) {
        let newScale: CGFloat = isHighlighted ? 0.95: 1.0
        let scaleAction = SKAction.scale(to: newScale, duration: 0.1)
        
        // let newColorBlendFactor: CGFloat = isHighlighted ? 1.0 : 0.0
        // let colorBlendAction = SKAction.colorizeWithColorBlendFactor(newColorBlendFactor, duration: 0.1)
        
        // node.runAction(SKAction.group([scaleAction, colorBlendAction]))
        node.run(scaleAction)
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodes(withName: "enemyPlane", using: {
            (node: SKNode?, stop) in
            let enemyPlane = node as! SKSpriteNode
            if enemyPlane.position.y < 0 - enemyPlane.size.height / 2 {
                enemyPlane.removeFromParent()
            }
        })
        self.enumerateChildNodes(withName: "myBullet", using: {
            (node: SKNode?, stop) in
            let myBullet = node as! SKSpriteNode
            if myBullet.position.y > self.size.height + myBullet.size.height / 2 {
                myBullet.removeFromParent()
            }
        })
        self.enumerateChildNodes(withName: "enemyBullet", using: {
            (node: SKNode?, stop) in
            let enemyBullet = node as! SKSpriteNode
            if enemyBullet.position.y < 0 - enemyBullet.size.height / 2 {
                enemyBullet.removeFromParent()
            }
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if IS_DEBUGGING {
            return
        }
        if (contact.bodyA.categoryBitMask == Category.myBullet && contact.bodyB.categoryBitMask == Category.enemyPlane) || (contact.bodyA.categoryBitMask == Category.enemyPlane && contact.bodyB.categoryBitMask == Category.myBullet) {
            if contact.bodyA.node != nil && contact.bodyB.node != nil {
                var myBullet: MyBullet
                var enemyPlane: EnemyPlane
                if contact.bodyA.categoryBitMask == Category.myBullet {
                    myBullet = contact.bodyA.node as! MyBullet
                    enemyPlane = contact.bodyB.node as! EnemyPlane
                } else {
                    enemyPlane = contact.bodyA.node as! EnemyPlane
                    myBullet = contact.bodyB.node as! MyBullet
                }
                
                let damage = myBullet.damage
                enemyPlane.healthPointNode.healthPoint -= damage
                
                myBullet.removeFromParent()
                
                if enemyPlane.healthPointNode.healthPoint <= 0 {
                    self.score += enemyPlane.score
                    enemyPlane.score = 0
                    self.run(SKAction.wait(forDuration: 0.25), completion: {
                        enemyPlane.removeFromParent()
                    })
                }
            }
        }
        
        if (contact.bodyA.categoryBitMask == Category.enemyBullet && contact.bodyB.categoryBitMask == Category.myPlane) || (contact.bodyA.categoryBitMask == Category.myPlane && contact.bodyB.categoryBitMask == Category.enemyBullet) {
            if contact.bodyA.node != nil && contact.bodyB.node != nil {
                var enemyBullet: EnemyBullet
                var myPlane: MyPlane
                if contact.bodyA.categoryBitMask == Category.enemyBullet {
                    enemyBullet = contact.bodyA.node as! EnemyBullet
                    myPlane = contact.bodyB.node as! MyPlane
                } else {
                    myPlane = contact.bodyA.node as! MyPlane
                    enemyBullet = contact.bodyB.node as! EnemyBullet
                }
                
                let damage = enemyBullet.damage
                myPlane.healthPointNode.healthPoint -= damage
                
                enemyBullet.removeFromParent()
                
                if myPlane.healthPointNode.healthPoint <= 0 {
                    self.run(SKAction.wait(forDuration: 0.25), completion: {
                        myPlane.removeFromParent()
                        self.endGame()
                    })
                }
            }
        }
        
        if (contact.bodyA.categoryBitMask == Category.enemyPlane && contact.bodyB.categoryBitMask == Category.myPlane) || (contact.bodyA.categoryBitMask == Category.myPlane && contact.bodyB.categoryBitMask == Category.enemyPlane) {
            if contact.bodyA.node != nil && contact.bodyB.node != nil {
                var enemyPlane: EnemyPlane
                var myPlane: MyPlane
                if contact.bodyA.categoryBitMask == Category.enemyBullet {
                    enemyPlane = contact.bodyA.node as! EnemyPlane
                    myPlane = contact.bodyB.node as! MyPlane
                } else {
                    myPlane = contact.bodyA.node as! MyPlane
                    enemyPlane = contact.bodyB.node as! EnemyPlane
                }
                
                myPlane.healthPointNode.healthPoint  = 0
                enemyPlane.healthPointNode.healthPoint = 0
                
                self.explodeAtPoint(myPlane.position)
                
                self.run(SKAction.wait(forDuration: 0.5), completion: {
                    self.myPlane.removeFromParent()
                    enemyPlane.removeFromParent()
                    self.endGame()
                })
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let minX = self.myPlane.size.width / 2
        let maxX = self.size.width - self.myPlane.size.width / 2
        
        let minY = self.myPlane.size.height / 2
        let maxY = self.size.height - self.myPlane.size.height / 2
        
        var newX: CGFloat = 0
        var newY: CGFloat = 0
        
        newX = CGFloat(self.maxAccelerometerX) * 10
        newY = CGFloat(self.maxAccelerometerY) * 10
        
        newX = min(max(newX + self.myPlane.position.x, minX), maxX)
        newY = min(max(newY + self.myPlane.position.y, minY), maxY)
        
        self.myPlane.position = CGPoint(x: newX, y: newY)
        
        let scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(SCORE) \(score)"
    }
    
    func explodeAtPoint(_ point: CGPoint) {
        let explosion = SKSpriteNode(texture: SKTexture(imageNamed: "Explosion"))
        explosion.position = point
        self.addChild(explosion)
        let zoom = SKAction.scale(by: 3.0, duration: 0.1);
        explosion.run(SKAction.repeat(zoom, count: 6))
    }
    
    func endGame() {
        let fade = SKTransition.fade(with: SKColor.white, duration: 1)
        let endScene = EndScene(fileNamed: "EndScene")
        if endScene != nil {
            endScene!.scaleMode = .aspectFit
            endScene!.score = self.score
            self.view!.presentScene(endScene!, transition: fade)
        }
    }
}
