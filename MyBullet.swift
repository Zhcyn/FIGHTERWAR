//
//  MyBullet.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class MyBullet: SKSpriteNode {
    let damage: Double = 5
    
    init() {
        super.init(texture: SKTexture(imageNamed: "MyBullet"), color: SKColor.clear, size: (UIImage(named: "MyBullet")?.size)!)
        
        self.name = "myBullet"
        self.zPosition = Layer.myBullet
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.myBullet
        self.physicsBody?.contactTestBitMask = Category.enemyPlane
        self.physicsBody?.collisionBitMask = UInt32(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
