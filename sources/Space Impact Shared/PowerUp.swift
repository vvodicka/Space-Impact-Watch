//
//  PowerUp.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 11/12/2020.
//

import SpriteKit

class PowerUp : SKSpriteNode {
    
    var powerUpSpeed: CGFloat!
    var actions: [SKAction] = []
    
    var nuke: (type: NukeType, count: Int)!
    
    private var frames: [SKTexture] = []
    
    let powerUpPossibilities : [(type: NukeType, count: Int)] = [(type: .line, count: 1), (type: .missle, count: 3), (type: .laser, count: 3)]
       
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        self.colorBlendFactor = 1
    }
    
    func spawn(spriteOrAtlas: String, y: CGFloat, moves: [CGPoint], powerUpSpeed: CGFloat) {
        self.nuke = powerUpPossibilities.randomElement()
        self.powerUpSpeed = powerUpSpeed
        
        let spriteAtlas = SKTextureAtlas(named: spriteOrAtlas)
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
            sprite = SKTexture(imageNamed: spriteOrAtlas)
        }
        
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        
        self.texture = sprite
        self.size = size
        self.color = GameScene.spriteColor
        
        animate()
        
        let seq = SKAction.sequence(getMoves(moves: moves, initialPosition: CGPoint(x: scene!.frame.maxX + self.frame.width/2, y: y * GameScene.pixelSize)))
        self.run(seq)
    }
    
    func getMoves(moves: [CGPoint], initialPosition: CGPoint) -> [SKAction] {
        var actions: [SKAction] = []
        actions.append(SKAction.move(to: initialPosition, duration: 0))
        for (index, move) in moves.enumerated() {
            let moveTransformedToPixelSize = CGPoint(x: move.x * GameScene.pixelSize, y: move.y * GameScene.pixelSize)
            let previousPositionTransformedToPixelSize = index == 0 ? initialPosition : CGPoint(x: moves[index - 1].x * GameScene.pixelSize, y: moves[index - 1].y * GameScene.pixelSize)
            
            let distance = previousPositionTransformedToPixelSize.distance(point: moveTransformedToPixelSize)
            let time = distance / powerUpSpeed
            
            actions.append(SKAction.move(to: moveTransformedToPixelSize, duration: TimeInterval(time)))
        }
        
        return actions
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collect() {
        removeSelf()
        GameScene.nukes.setNukes(nuke: self.nuke)
        GameScene.player.heal()
    }
    
    func getSKSpriteNode() -> SKSpriteNode {
        return self
    }
    
    func animate() {
        self.run(SKAction.repeatForever(
        SKAction.animate(with: frames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
        withKey:"powerUpAnimation")
    }
    
    func removeSelf() {
        self.removeAllActions()
        for (index, powerUp) in GameScene.powerUps.enumerated() {
            if powerUp == self {
                GameScene.powerUps.remove(at: index)
            }
        }
        self.removeFromParent()
    }
    
    func update() {
        if let scene = scene {
            self.position.x -= powerUpSpeed * CGFloat(GameScene.deltaTime)
            
            if self.position.x < scene.frame.minX - self.frame.width/2 {
                removeSelf()
            }
        }
    }
    
}
