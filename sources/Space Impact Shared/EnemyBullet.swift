//
//  EnemyBullet.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 20/01/2021.
//

import SpriteKit

class EnemyBullet : SKSpriteNode {
    
    var bulletSpeed: CGFloat = 35
   
    init() {
        let sprite = SKTexture(imageNamed: "player_bullet")
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeSelf() {
        self.isHidden = true
    }
    
    func update() {
        if let scene = scene {
            self.position.x -= bulletSpeed * CGFloat(GameScene.deltaTime)
            
            if self.position.x < scene.frame.minX {
                removeSelf()
            }
        }
    }
}

