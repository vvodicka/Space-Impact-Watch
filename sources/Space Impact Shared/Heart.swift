//
//  Heart.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 03/12/2020.
//

import SpriteKit

class Heart : SKSpriteNode {
       
    init(name: String) {
        let sprite = SKTexture(imageNamed: "heart")
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        self.name = name
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

