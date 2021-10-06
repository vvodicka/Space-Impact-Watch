//
//  FinalBoss.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 03/05/2021.
//

import SpriteKit

class FinalBoss : SKSpriteNode {
    
    var bossSpeed: CGFloat!
    var currentHealth: Int!
    var score: Int!
    var spawnTime: Date!
    var randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?
    var lastBlinkTime: Date = Date()
    var nextRandomMissleShotTime: Date?
    var appeared = false
    
    var actions: [SKAction] = []
    
    private var frames: [SKTexture] = []
    private var moveSequence : SKAction?
    
    private var nextMegaspawnTime: Date?
    var megaSpawning = false
    
    var tentacles: [Tentacle] = []
    var eyeCollider : SKSpriteNode?
    
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        
        self.colorBlendFactor = 1
        
        megaSpawning = false
        nextMegaspawnTime = nil
    }
    
    func spawn(spriteOrAtlas: String, bossSpeed: CGFloat, health: Int, score: Int, randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?) {
        self.spawnTime = Date()
        
        self.randomMissleShootTimeIntervalRange = randomMissleShootTimeIntervalRange
        self.currentHealth = health
        self.bossSpeed = bossSpeed
        self.score = score
        self.position = CGPoint(x: scene!.frame.maxX + self.frame.width/2, y: 0)
        
        computeNextRandomMissleShotTime()
        
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
        
        if numImages > 0 {
            animate()
        }
        
        let appear = SKAction.sequence(getAppearMoves())
        
        let seq = SKAction.sequence([appear])
        self.run(seq)
        
        spawnTentacle(initialPosition: CGPoint(x: 51 * GameScene.pixelSize, y: 1 * GameScene.pixelSize), targetPosition: CGPoint(x: 13 * GameScene.pixelSize, y: 1 * GameScene.pixelSize))
        spawnTentacle(initialPosition: CGPoint(x: 49 * GameScene.pixelSize, y: -5 * GameScene.pixelSize), targetPosition: CGPoint(x: 11 * GameScene.pixelSize, y: -5 * GameScene.pixelSize))
    }
    
    func spawnTentacle(initialPosition : CGPoint, targetPosition: CGPoint) {
        let tentacle = Tentacle()
        tentacle.spawn(bossSpeed: bossSpeed, initialPosition: initialPosition, targetPosition: targetPosition)
        
        tentacles.append(tentacle)
    }
    
    func computeNextRandomMissleShotTime() {
        if let randomMissleShootTimeIntervalRange = randomMissleShootTimeIntervalRange {
            nextRandomMissleShotTime = Date().addingTimeInterval(TimeInterval.random(in: randomMissleShootTimeIntervalRange.min..<randomMissleShootTimeIntervalRange.max))
        } else {
            nextRandomMissleShotTime = nil
        }
    }
    
    func getAppearMoves() -> [SKAction] {
        var actions: [SKAction] = []
        let initialPosition = CGPoint(x: scene!.frame.maxX + self.frame.width/2, y: 0)
        actions.append(SKAction.move(to: initialPosition, duration: 0))
        
        let readyPosition = CGPoint(x: scene!.frame.maxX - self.frame.width/2, y: 0)
        let readyDistance = initialPosition.distance(point: readyPosition)
        let readyTime = readyDistance / bossSpeed
        actions.append(SKAction.move(to: readyPosition, duration: TimeInterval(readyTime)))
        
        let appeared: SKAction = SKAction.run {
            self.appeared = true
        }
        actions.append(appeared)
        
        return actions
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(damage: Int) {
        GameScene.score.addScore(value: damage*5)
        currentHealth -= damage
        blink(objectToBlink: self)
        if currentHealth <= 0 {
            die()
        }
    }
    
    func blink(objectToBlink : SKSpriteNode) {
        if Date() - lastBlinkTime > 1 {
            lastBlinkTime = Date()
            
            let hide: SKAction = SKAction.run {
                objectToBlink.isHidden = true
            }
            
            let wait: SKAction = SKAction.wait(forDuration: 0.1)
            
            let show: SKAction = SKAction.run {
                objectToBlink.isHidden = false
            }
            
            let seq: SKAction = SKAction.sequence([hide, wait, show])
            objectToBlink.run(seq)
        }
    }
    
    func die() {
        self.removeAllActions()
        spawnExplosions()
        
        self.removeFromParent()
        eyeCollider = nil
        GameScene.interfaceDelegate.vibrate(.success)
        GameScene.score.addScore(value: score)
        
        removeAllEnemyMissles()
        
        GameScene.boss = nil
        
        GameScene.player.levelWinSequence()
    }
    
    func spawnExplosions() {
        for index in 1..<9 {
            let randomX = CGFloat.random(in: self.position.x - self.frame.width/2 + 2.5 * GameScene.pixelSize ... self.position.x + self.frame.width/2 - 2.5 * GameScene.pixelSize)
            let randomY = CGFloat.random(in: self.position.y - self.frame.height/2 + 2.5 * GameScene.pixelSize ... self.position.y + self.frame.height/2 - 2.5 * GameScene.pixelSize)
            let randomPosition = CGPoint(x: randomX, y: randomY)
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.15) {
                Explosion(position: randomPosition, size: .big)
            }
        }
    }
    
    func removeAllEnemyMissles() {
        for missleNuke in Nukes.missleNukes {
            if missleNuke.playerIsTarget == true {
                missleNuke.removeSelf()
            }
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
    
    func update(inLevelTime: TimeInterval) {
        if currentHealth < 0 {
            return
        }
        
        if let nextRandomMissleShotTime = self.nextRandomMissleShotTime {
            if Date() > nextRandomMissleShotTime {
                shootMissle()
                computeNextRandomMissleShotTime()
            }
        }
        
        if let nextMegaspawnTime = self.nextMegaspawnTime {
            if Date() > nextMegaspawnTime {
                if !megaSpawning {
                    megaSpawn()
                }
            }
        }
        
        var tentaclesDown = true
        
        for tentacle in tentacles {
            checkTentacleCollision(tentacle: tentacle)
            if tentacle.currentHealth > 0 {
                tentaclesDown = false
            }
        }
        
        if tentaclesDown && eyeCollider == nil {
            spawnEyeCollider()
            computeMegaSpawnTime()
        }
        
        if let eyeCollider = eyeCollider {
            for playerBullet in GameScene.playerBullets {
                if !playerBullet.isHidden && eyeCollider.frame.intersects(playerBullet.frame) && currentHealth > 0 && !megaSpawning {
                    playerBullet.removeSelf()
                    hit(damage: 1)
                }
            }
            for missleNuke in Nukes.missleNukes {
                if !missleNuke.isHidden && eyeCollider.frame.intersects(missleNuke.frame) && missleNuke.playerIsTarget == false && currentHealth > 0 && !megaSpawning {
                    missleNuke.removeSelf()
                    hit(damage: missleNuke.damage)
                }
            }
        }
    }
    
    func megaSpawn() {
        megaSpawning = true
        var actions: [SKAction] = []
        
        let initialPosition = position
        let targetPosition = CGPoint(x: scene!.frame.maxX + frame.width/2, y: position.y)
        
        let readyDistance = initialPosition.distance(point: targetPosition)
        let readyTime = readyDistance / bossSpeed
        
        actions.append(SKAction.move(to: targetPosition, duration: TimeInterval(readyTime)))
        
        let appeared: SKAction = SKAction.run {
            for x in 0..<2 {
                for y in 0..<3 {
                    let minion = Enemy()
                    GameScene.enemies.append(minion)
                    GameScene.scene.addChild(minion)
                    
                    let posY = CGFloat(8 - 4 * y) * GameScene.pixelSize
                    let posX = CGFloat(48 + 10 * x) * GameScene.pixelSize
                    
                    let moves = [CGPoint(x: -48, y: posY)]
                    
                    minion.spawn(spriteOrAtlas: "Beatle2", health: 3, y: posY, initialX: posX, moves: moves, enemySpeed: 40, shootInterval: nil, randomShootTimeIntervalRange: nil, singleShootTimes: nil, score: 0, isMinion: true)
                }
            }
        }
        actions.append(appeared)
        
        actions.append(SKAction.wait(forDuration: 1))

        actions.append(SKAction.move(to: initialPosition, duration: TimeInterval(readyTime)))
        
        let seq = SKAction.sequence(actions)
        
        self.run(seq, completion: {() -> Void in
            self.megaSpawning = false
            self.computeMegaSpawnTime()
        })
    }
    
    func computeMegaSpawnTime() {
        nextMegaspawnTime = Date().addingTimeInterval(TimeInterval.random(in: 2..<4))
    }
    
    func spawnEyeCollider() {
        let eyeCollider = SKSpriteNode()
        eyeCollider.size = CGSize(width: 6 * GameScene.pixelSize, height: 10 * GameScene.pixelSize)
        eyeCollider.position = CGPoint(x: 29 * GameScene.pixelSize, y: -1 * GameScene.pixelSize)
        GameScene.scene.addChild(eyeCollider)
        self.eyeCollider = eyeCollider
        
    }
    
    func checkTentacleCollision(tentacle : Tentacle) {
        for playerBullet in GameScene.playerBullets {
            //bullet vs tentacle
            if !tentacle.isHidden && !playerBullet.isHidden && tentacle.frame.intersects(playerBullet.frame) {
                playerBullet.removeSelf()
                tentacle.hit(damage: 1)
            }
            
            for missleNuke in Nukes.missleNukes {
                //missle vs tentacle
                if !missleNuke.isHidden && !tentacle.isHidden && tentacle.frame.intersects(missleNuke.frame) && missleNuke.playerIsTarget == false {
                    missleNuke.removeSelf()
                    tentacle.hit(damage: missleNuke.damage)
                }
            }
        }
    }
    
    func shootMissle() {
        let missle = instantiateMissle()
        
        let y = CGFloat.random(in: self.position.y - self.frame.height / 3 ... self.position.y + self.frame.height / 3)

        let misslePosition = CGPoint(x: self.position.x - frame.width/2 + missle.frame.width/2, y: y)
        missle.position = misslePosition
    }
    
    func instantiateMissle() -> MissleNuke {
        let missleNuke = MissleNuke(playerIsTarget: true)
        Nukes.missleNukes.append(missleNuke)
        GameScene.scene.addChild(missleNuke)
        return missleNuke
    }
}
