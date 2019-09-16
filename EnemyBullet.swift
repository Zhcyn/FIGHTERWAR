//
//  EnemyBullet.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class EnemyBullet: SKSpriteNode {
    let damage: Double = 5
    
    init() {
        super.init(texture: SKTexture(imageNamed: "EnemyBullet"), color: SKColor.clear, size: (UIImage(named: "EnemyBullet")?.size)!)
        
        self.name = "enemyBullet"
        self.zPosition = Layer.enemyBullet
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.enemyBullet
        self.physicsBody?.contactTestBitMask = Category.myPlane
        self.physicsBody?.collisionBitMask = UInt32(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
