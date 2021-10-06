//
//  Tentacle.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 04/05/2021.
//

import SpriteKit

class Tentacle : SKSpriteNode {
    
    var id = UUID()
    var currentHealth: Int = 40
    var lastBlinkTime: Date = Date()
    var bossSpeed: CGFloat!
    var initialPosition: CGPoint!
    var targetPosition: CGPoint!
    
    var actions: [SKAction] = []
    
    private var frames: [SKTexture] = []
    private var moveSequence : SKAction?
    private var dead = false
    
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        
        self.colorBlendFactor = 1
        
        GameScene.scene.addChild(self)
    }
    
    func spawn(bossSpeed: CGFloat, initialPosition: CGPoint, targetPosition: CGPoint) {
        self.bossSpeed = bossSpeed
        self.position = initialPosition
        self.initialPosition = initialPosition
        self.targetPosition = targetPosition
        
        let spriteAtlas = SKTextureAtlas(named: "FinalBossTentacle")
        var frames: [SKTexture] = []
        let numImages = spriteAtlas.textureNames.count
        
        var sprite: SKTexture
        if numImages > 0 {
            for i in 0...numImages - 1 {
                let spriteName = "frame000\(i)"
                frames.append(spriteAtlas.textureNamed(spriteName))
            }
            self.frames = frames
            let firstFrame = frames[0]
            
            sprite = firstFrame
        } else {
            sprite = SKTexture(imageNamed: "FinalBossTentacle")
        }
        
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        
        self.texture = sprite
        self.size = size
        self.color = GameScene.spriteColor
        
        if numImages > 0 {
            animate()
        }
        
        let appear = SKAction.sequence(getAppearMoves())
        
        let seq = SKAction.sequence([appear])
        self.run(seq)
    }
    
    func getAppearMoves() -> [SKAction] {
        var actions: [SKAction] = []
        
        let readyDistance = initialPosition.distance(point: targetPosition)
        let readyTime = readyDistance / bossSpeed
        actions.append(SKAction.move(to: targetPosition, duration: TimeInterval(readyTime)))
        
        return actions
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(damage: Int) {
        if !dead {
            currentHealth -= damage
            blink()
            if currentHealth <= 0 {
                dead = true
                die()
            }
        }
    }
    
    func die() {
        var actions: [SKAction] = []
        
        let targetPosition = CGPoint(x: scene!.frame.minX - frame.width, y: position.y)
        
        let readyDistance = initialPosition.distance(point: targetPosition)
        let readyTime = readyDistance / 100
        actions.append(SKAction.move(to: targetPosition, duration: TimeInterval(readyTime)))
        
        let seq = SKAction.sequence(actions)
        self.run(seq, completion: {() -> Void in
            self.isHidden = true
        })
    }
    
    func blink() {
        if Date() - lastBlinkTime > 1 {
            lastBlinkTime = Date()
            
            let hide: SKAction = SKAction.run {
                self.isHidden = true
            }
            
            let wait: SKAction = SKAction.wait(forDuration: 0.1)
            
            let show: SKAction = SKAction.run {
                self.isHidden = false
            }
            
            let seq: SKAction = SKAction.sequence([hide, wait, show])
            run(seq)
        }
    }
    
    func getSKSpriteNode() -> SKSpriteNode {
        return self
    }
    
    func animate() {
        self.run(SKAction.repeatForever(
                    SKAction.animate(with: frames,
                                     timePerFrame: 0.3,
                                     resize: false,
                                     restore: true))
        )
    }
    
    func getPosition() -> CGPoint {
        return self.position
    }
}
