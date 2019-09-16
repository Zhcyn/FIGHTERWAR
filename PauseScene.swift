//
//  PauseScene.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/3/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class PauseScene: SKScene {
    var buttonPressed =  SKSpriteNode()
    var resumeButton = SKSpriteNode()
    var restartButton = SKSpriteNode()
    var homeButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.resumeButton = self.childNode(withName: "Resume") as! SKSpriteNode
        self.restartButton = self.childNode(withName: "Restart") as! SKSpriteNode
        self.homeButton = self.childNode(withName: "Home") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.containTouches(touches, inNode: self.resumeButton) {
            self.shouldHighlightNode(true, node: self.resumeButton)
            self.buttonPressed = self.resumeButton
        } else if self.containTouches(touches, inNode: self.restartButton) {
            self.shouldHighlightNode(true, node: self.restartButton)
            self.buttonPressed = self.restartButton
        } else if self.containTouches(touches, inNode: self.homeButton) {
            self.shouldHighlightNode(true, node: self.homeButton)
            self.buttonPressed = self.homeButton
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.containTouches(touches, inNode: self.buttonPressed) {
            self.shouldHighlightNode(false, node: self.buttonPressed)
        } else {
            self.shouldHighlightNode(true, node: self.buttonPressed)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.containTouches(touches, inNode: self.buttonPressed) {
            self.shouldHighlightNode(false, node: self.buttonPressed)
            if self.buttonPressed === self.resumeButton {
                self.run(SKAction.wait(forDuration: 0.1), completion: {
                    // self.resumeGame()
                })
            } else if self.buttonPressed === self.restartButton {
                self.run(SKAction.wait(forDuration: 0.1), completion: {
                    self.newGame()
                })
            } else if self.buttonPressed === self.homeButton {
                self.run(SKAction.wait(forDuration: 0.1), completion: {
                    self.goHome()
                })
            }
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
        
        let newColorBlendFactor: CGFloat = isHighlighted ? 1.0 : 0.0
        let colorBlendAction = SKAction.colorize(withColorBlendFactor: newColorBlendFactor, duration: 0.1)
        
        node.run(SKAction.group([scaleAction, colorBlendAction]))
    }
    
    func newGame() {
        let fade = SKTransition.fade(with: SKColor.white, duration: 1)
        let gameScene = GameScene(fileNamed: "GameScene")
        if gameScene != nil {
            self.view!.presentScene(gameScene!, transition: fade)
        }
    }
    
    func goHome() {
        let fade = SKTransition.fade(with: SKColor.white, duration: 1)
        let homeScene = HomeScene(fileNamed: "HomeScene")
        if homeScene != nil {
            homeScene!.scaleMode = .aspectFit
            self.view!.presentScene(homeScene!, transition: fade)
        }
    }
}
