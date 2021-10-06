//
//  BackgroundTile.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 26/01/2021.
//

import SpriteKit

class BackgroundTile : SKSpriteNode {
    
    let backgroundSpeed: CGFloat = 25
   
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        self.colorBlendFactor = 1
    }
    
    func spawn(sprite: SKTexture, x: CGFloat) {
        
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        
        var y: CGFloat!
        switch GameScene.hudPosition {
            case .top:
                y = -24 * GameScene.pixelSize + size.height/2
            case .bottom:
                y = 24 * GameScene.pixelSize - size.height/2
        }
        
        self.position = CGPoint(x: x, y: y)
        
        self.texture = sprite
        self.size = size
        self.color = GameScene.spriteColor
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let size = CGSize(width: texture!.size().width/10 * GameScene.pixelSize, height: texture!.size().height/10 * GameScene.pixelSize)
        super.init(texture: texture, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func translateToEnd() {
        var maxX: CGFloat = CGFloat.leastNormalMagnitude
        for backgroundTile in GameScene.backgroundTiles {
            if backgroundTile.position.x > maxX {
                maxX = backgroundTile.position.x
            }
        }
        self.position.x = maxX + self.frame.width
    }
    
    func update() {
        if let scene = scene {
            self.position.x -= backgroundSpeed * CGFloat(GameScene.deltaTime)
            
            if self.position.x < scene.frame.minX - self.frame.width/2 {
                translateToEnd()
            }
        }
    }
}
