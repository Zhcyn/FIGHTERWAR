//
//  EnemyPlaneEasy.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class EnemyPlaneEasy: EnemyPlane {
    override init() {
        super.init()
        
        self.texture = SKTexture(imageNamed: "EnemyPlaneEasy")
        
        self.score = 1
        
        self.healthPointNode = HealthPoint(healthPoint: 20)
        self.healthPointNode.position = CGPoint(x: 0, y: self.size.height / 2 + 10)
        self.addChild(self.healthPointNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fireBullet() {
        self.fireBulletAtAngle(.pi / 12 * 17, delay: 0)
        self.fireBulletAtAngle(.pi / 12 * 19, delay: 0)
    }
    
    fileprivate func fireBulletAtAngle(_ angle: CGFloat, delay: TimeInterval) {
        guard let parentScene = self.parent as? SKScene else {
            return
        }
        
        let enemyBullet = EnemyBullet()
        parentScene.run(SKAction.wait(forDuration: delay), completion: {
            enemyBullet.position = CGPoint(x: self.position.x, y: self.position.y - self.size.height / 2)
            enemyBullet.run(SKAction.rotate(byAngle: angle - .pi / 4, duration: 0))
            parentScene.addChild(enemyBullet)
            enemyBullet.physicsBody?.applyImpulse(self.vectorWithMagnitude(ENEMY_BULLET_IMPULSE_MAGNITUDE, angle: angle))
        })
    }
    
    fileprivate func vectorWithMagnitude(_ magnitude: CGFloat, angle: CGFloat) -> CGVector {
        let x = magnitude * cos(angle)
        let y = magnitude * sin(angle)
        return CGVector(dx: x, dy: y)
    }
}
