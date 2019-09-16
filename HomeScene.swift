//
//  HomeScene.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/1/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene {
    var buttonPressed =  SKSpriteNode()
    var newButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.newButton = self.childNode(withName: "Restart") as! SKSpriteNode
        
        self.showHighScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.containTouches(touches, inNode: self.newButton) {
            self.shouldHighlightNode(true, node: self.newButton)
            self.buttonPressed = self.newButton
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
            if self.buttonPressed === self.newButton {
                self.run(SKAction.wait(forDuration: 0.1), completion: {
                    self.newGame()
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
    
    func showHighScore() {
        if UserDefaults.standard.object(forKey: "highScore") == nil {
            UserDefaults.standard.set(0, forKey: "highScore")
        }
        let highScoreNode = self.childNode(withName: "HighScoreText") as! SKLabelNode
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        if highScore == 0 || IS_DEBUGGING {
            highScoreNode.text = ""
        } else {
            highScoreNode.text = "\(HIGH_SCORE) \(highScore)"
        }
    }
    
    func newGame() {
        let fade = SKTransition.fade(with: SKColor.white, duration: 1)
        let gameScene = GameScene(fileNamed: "GameScene")
        if gameScene != nil {
            self.view!.presentScene(gameScene!, transition: fade)
        }
    }
}
