//
//  EnemyPlane.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class EnemyPlane: SKSpriteNode {
    var score: Int = 0
    
    var healthPointNode: HealthPoint = HealthPoint()
    
    init() {
        super.init(texture: SKTexture(imageNamed: "EnemyPlane"), color: SKColor.clear, size: (UIImage(named: "EnemyPlane")?.size)!)
        
        self.name = "enemyPlane"
        self.zPosition = Layer.enemyPlane
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.enemyPlane
        self.physicsBody?.contactTestBitMask = UInt32(0)
        self.physicsBody?.collisionBitMask = UInt32(0)
        
        let fireBulletAction = SKAction.run({
            self.fireBullet()
        })
        let wait = SKAction.wait(forDuration: ENEMY_BULLET_TIME_INTERVAL)
        self.run(SKAction.repeatForever(SKAction.sequence([fireBulletAction, wait])))
        
        let moveDown = SKAction.moveBy(x: 0, y: -100, duration: 1)
        self.run(SKAction.repeatForever(moveDown))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fireBullet() {
        
    }
}
