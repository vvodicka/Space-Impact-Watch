//
//  Enemy1.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 30/11/2020.
//

import SpriteKit

class Enemy : SKSpriteNode {
    
    var enemySpeed: CGFloat!
    var currentHealth: Int!
    var score: Int!
    var spawnTime: Date!
    var shootInterval: TimeInterval?
    var randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?
    var singleShootTimes: [TimeInterval]?
    var lastPeriodicShotTime: Date = Date()
    var nextRandomShotTime: Date?
    var id = UUID()
    
    var isMinion: Bool?
    
    var actions: [SKAction] = []
    
    private var frames: [SKTexture] = []
       
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        self.colorBlendFactor = 1
    }
    
    func spawn(spriteOrAtlas: String, health: Int, y: CGFloat, initialX: CGFloat? = nil, moves: [CGPoint], enemySpeed: CGFloat, shootInterval: TimeInterval?, randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, singleShootTimes: [TimeInterval]?, score: Int, isMinion: Bool? = nil) {
        self.id = UUID()
        self.spawnTime = Date()
        self.shootInterval = shootInterval
        self.randomShootTimeIntervalRange = randomShootTimeIntervalRange
        self.singleShootTimes = singleShootTimes
        self.currentHealth = health
        self.enemySpeed = enemySpeed
        self.score = score
        self.position = CGPoint(x: initialX != nil ? initialX! : scene!.frame.maxX + self.frame.width/2, y: y * GameScene.pixelSize)
        self.isHidden = false
        self.isMinion = isMinion
        
        computeNextRandomShotTime()
        
        let spriteAtlas = SKTextureAtlas(named: spriteOrAtlas)
        var frames: [SKTexture] = []
        let numImages = spriteAtlas.textureNames.count
        
        var sprite: SKTexture!
        if numImages > 0 {
            for i in 0...numImages - 1 {
                let spriteName = "frame000\(i)"
                frames.append(spriteAtlas.textureNamed(spriteName))
            }
            self.frames = frames
            let firstFrame = frames[0]

            sprite = firstFrame
        }
        
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        
        self.texture = sprite
        self.size = size
        self.color = GameScene.spriteColor

        if numImages > 0 {
            animate()
        }
        
        let seq = SKAction.sequence(getMoves(moves: moves, initialPosition: CGPoint(x: initialX != nil ? initialX! : scene!.frame.maxX + self.frame.width/2, y: y * GameScene.pixelSize)))
        self.run(seq)
    }
    
    func computeNextRandomShotTime() {
        if let randomShootTimeIntervalRange = randomShootTimeIntervalRange {
            nextRandomShotTime = Date().addingTimeInterval(TimeInterval.random(in: randomShootTimeIntervalRange.min..<randomShootTimeIntervalRange.max))
        } else {
            nextRandomShotTime = nil
        }
    }
    
    func getMoves(moves: [CGPoint], initialPosition: CGPoint) -> [SKAction] {
        var actions: [SKAction] = []
        actions.append(SKAction.move(to: initialPosition, duration: 0))
        for (index, move) in moves.enumerated() {
            let moveTransformedToPixelSize = CGPoint(x: move.x * GameScene.pixelSize, y: move.y * GameScene.pixelSize)
            let previousPositionTransformedToPixelSize = index == 0 ? initialPosition : CGPoint(x: moves[index - 1].x * GameScene.pixelSize, y: moves[index - 1].y * GameScene.pixelSize)
            
            let distance = previousPositionTransformedToPixelSize.distance(point: moveTransformedToPixelSize)
            let time = distance / enemySpeed
            
            actions.append(SKAction.move(to: moveTransformedToPixelSize, duration: TimeInterval(time)))
        }
        
        return actions
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(damage: Int) {
        currentHealth -= damage
        GameScene.score.addScore(value: damage*5)
        if currentHealth <= 0 {
            die()
        }
    }
    
    func die() {
        self.removeAllActions()
        Explosion(position: self.position, size: .big)
        
        removeSelf()
        GameScene.interfaceDelegate.vibrate(.click)
        GameScene.score.addScore(value: score)
    }
    
    func removeSelf() {
        self.isHidden = true
    }
    
    func getSKSpriteNode() -> SKSpriteNode {
        return self
    }
    
    func animate() {
        self.run(SKAction.repeatForever(
        SKAction.animate(with: frames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true))
        )
    }
    
    func getPosition() -> CGPoint {
        return self.position
    }
    
    func update(inLevelTime: TimeInterval) {
        if self.isHidden {
            return
        }
        
        if let scene = scene {
            if self.position.x < scene.frame.minX - self.frame.width/2 {
                removeSelf()
            }
        }
        
        let aliveTime = Date() - spawnTime
        
        if let singleShootTimes = singleShootTimes {
            if singleShootTimes.count > 0 {
                for (index, singleShootTime) in singleShootTimes.enumerated() {
                    if aliveTime > singleShootTime {
                        self.singleShootTimes?.remove(at: index)
                        shoot()
                    }
                }
            }
        }
        
        if let shootInterval = self.shootInterval {
            if Date() - lastPeriodicShotTime > shootInterval {
                lastPeriodicShotTime = Date()
                shoot()
            }
        }
        
        if let nextRandomShotTime = self.nextRandomShotTime {
            if Date() > nextRandomShotTime {
                shoot()
                computeNextRandomShotTime()
            }
        }
    }
    
    func shoot() {
        let bullet = getBullet()
        let bulletPosition = CGPoint(x: self.position.x - self.frame.width/2 - bullet.frame.width/2, y: self.position.y)
        bullet.position = bulletPosition
        bullet.isHidden = false
        bullet.bulletSpeed = enemySpeed * 1.2
    }
    
    func getBullet() -> EnemyBullet {
        for bullet in GameScene.enemyBullets {
            if bullet.isHidden {
                return bullet
            }
        }
        return instantiateBullet()
    }
    
    func instantiateBullet() -> EnemyBullet {
        let bullet = EnemyBullet()
        GameScene.enemyBullets.append(bullet)
        scene?.addChild(bullet)
        return bullet
    }
}
