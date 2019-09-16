//
//  HealthPoint.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class HealthPoint: SKSpriteNode {
    var totalHealthPoint: Double = 0
    
    var healthPoint: Double = 0 {
        didSet {
            if self.healthPoint < 0 {
                self.healthPoint = 0
            }
            let percentage = self.healthPoint / self.totalHealthPoint
            let healthPointLevel = self.childNode(withName: "healthPointInner")?.childNode(withName: "healthPointLevel") as! SKSpriteNode
            healthPointLevel.run(SKAction.scaleX(to: CGFloat(percentage), duration: 0.25))
        }
    }
    
    convenience init() {
        self.init(healthPoint: 0)
    }
    
    init(healthPoint: Double) {
        super.init(texture: nil, color: SKColor.black, size: CGSize(width: 50, height: 10))
        self.name = "healthPoint"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let healthPointInner = SKSpriteNode(color: SKColor.white, size: CGSize(width: 46, height: 6))
        healthPointInner.name = "healthPointInner"
        healthPointInner.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        healthPointInner.position = CGPoint(x: 0, y: 0)
        
        let healthPointLevel = SKSpriteNode(color: SKColor.black, size: CGSize(width: 46, height: 6))
        healthPointLevel.name = "healthPointLevel"
        healthPointLevel.anchorPoint = CGPoint(x: 0, y: 0.5)
        healthPointLevel.position = CGPoint(x: -23, y: 0)
        
        healthPointInner.addChild(healthPointLevel)
        self.addChild(healthPointInner)
        
        self.healthPoint = healthPoint
        self.totalHealthPoint = healthPoint
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
