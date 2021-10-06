//
//  Explosion.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 04/12/2020.
//

import SpriteKit

enum ExplosionSize {
    case big
    case small
}

class Explosion : SKSpriteNode {
       
    private var bigExplosionFrames: [SKTexture] = []
    private var smallExplosionFrames: [SKTexture] = []

    init(position: CGPoint, size: ExplosionSize) {
        let spriteAtlas = SKTextureAtlas(named: "Explosion")
        var frames: [SKTexture] = []
        let numImages = spriteAtlas.textureNames.count
          for i in 0...numImages - 1 {
            let spriteName = "frame000\(i)"
            frames.append(spriteAtlas.textureNamed(spriteName))
          }
        self.bigExplosionFrames = frames
        self.smallExplosionFrames = Array(frames[1...frames.count - 1])
        let firstFrame = frames[0]

        let sprite = firstFrame
        let spriteSize = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: spriteSize)
        self.colorBlendFactor = 1
        GameScene.scene.addChild(self)
        spawn(position: position, size: size)
    }
    
    func spawn(position: CGPoint, size: ExplosionSize) {
        self.position = position        
        var frames: [SKTexture] = []
        switch size {
        case .big: frames = bigExplosionFrames
        case .small: frames = smallExplosionFrames
        }
        
        let animation = SKAction.animate(with: frames,
                                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)
        
        let hide: SKAction = SKAction.run {
            self.removeFromParent()
        }
        
        let seq = SKAction.sequence([animation, hide])
        self.run(seq)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

