//
//  MyPlane.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class MyPlane: SKSpriteNode {
    var healthPointNode: HealthPoint = HealthPoint()
    
    init() {
        super.init(texture: SKTexture(imageNamed: "MyPlane"), color: SKColor.clear, size: (UIImage(named: "MyPlane")?.size)!)
        
        self.name = "myPlane"
        self.zPosition = Layer.myPlane
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.myPlane
        self.physicsBody?.contactTestBitMask = Category.enemyPlane
        self.physicsBody?.collisionBitMask = UInt32(0)
        
        self.healthPointNode = HealthPoint(healthPoint: 100)
        self.healthPointNode.position = CGPoint(x: 0, y: -self.size.height / 2 - 10)
        self.addChild(self.healthPointNode)
        
        if IS_DEBUGGING {
            self.healthPointNode.healthPoint /= 2
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fireNormalBullet() {
        self.fireBulletAtAngle(.pi / 2, delay: 0)
    }
    
    func firePowerfulBullet() {
        for i in 0...12 {
            self.fireBulletAtAngle(.pi / 12 * (12 - CGFloat(i)), delay: Double(i) / 12)
        }
        for i in 12...24 {
            self.fireBulletAtAngle(.pi / 12 * (CGFloat(i) - 12), delay: Double(i) / 12)
        }
    }
    
    fileprivate func fireBulletAtAngle(_ angle: CGFloat, delay: TimeInterval) {
        guard let parentScene = self.parent as? SKScene else {
            return
        }
        
        let myBullet = MyBullet()
        parentScene.run(SKAction.wait(forDuration: delay), completion: {
            myBullet.position = CGPoint(x: self.position.x, y: self.position.y + self.size.height / 2)
            myBullet.run(SKAction.rotate(byAngle: angle - .pi / 2, duration: 0))
            parentScene.addChild(myBullet)
            myBullet.physicsBody?.applyImpulse(self.vectorWithMagnitude(MY_BULLET_IMPULSE_MAGNITUDE, angle: angle))
        })
    }
    
    fileprivate func vectorWithMagnitude(_ magnitude: CGFloat, angle: CGFloat) -> CGVector {
        let x = magnitude * cos(angle)
        let y = magnitude * sin(angle)
        return CGVector(dx: x, dy: y)
    }
}
