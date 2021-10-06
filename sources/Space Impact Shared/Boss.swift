//
//  Boss.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 21/01/2021.
//

import SpriteKit

class Boss : SKSpriteNode {
    
    var bossSpeed: CGFloat!
    var currentHealth: Int!
    var score: Int!
    var spawnTime: Date!
    var shootInterval: TimeInterval?
    var randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?
    var randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?
    var singleShootTimes: [TimeInterval]?
    var lastBlinkTime: Date = Date()
    var lastPeriodicShotTime: Date = Date()
    var nextRandomShotTime: Date?
    var nextRandomMissleShotTime: Date?
    var appeared = false
    var yOffset : Int?
    var charge: (interval: TimeInterval, hideBefore: Bool)?
    var lastChargeTime: Date = Date()
    
    var minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)?
    var nextMinionSpawnTime: Date?
    
    private var charging = false
    
    var actions: [SKAction] = []
    
    private var frames: [SKTexture] = []
    private var moveSequence : SKAction?
    
    init() {
        let empty = SKSpriteNode()
        super.init(texture: empty.texture, color: empty.color, size: empty.size)
        self.colorBlendFactor = 1
    }
    
    func spawn(spriteOrAtlas: String, bossSpeed: CGFloat, health: Int, score: Int, shootInterval: TimeInterval?, randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, singleShootTimes: [TimeInterval]?, yOffset: Int?, charge: (interval: TimeInterval, hideBefore: Bool)?, randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)?) {
        self.spawnTime = Date()
        self.shootInterval = shootInterval
        self.singleShootTimes = singleShootTimes
        self.randomShootTimeIntervalRange = randomShootTimeIntervalRange
        self.randomMissleShootTimeIntervalRange = randomMissleShootTimeIntervalRange
        self.currentHealth = health
        self.bossSpeed = bossSpeed
        self.score = score
        self.position = CGPoint(x: scene!.frame.maxX + self.frame.width/2, y: 0)
        self.yOffset = yOffset
        self.charge = charge
        self.minionSpawner = minionSpawner
        
        computeNextRandomShotTime()
        computeNextRandomMissleShotTime()
        computeNextMinionSpawnTime()
        
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
        
        var topY : CGFloat = 0
        var bottomY: CGFloat = 0
        switch GameScene.hudPosition {
        case .top:
            topY = 17 * GameScene.pixelSize - self.frame.height/2
            bottomY = CGFloat(-24 + (yOffset ?? 0)) * GameScene.pixelSize + self.frame.height/2
        case .bottom:
            topY = CGFloat(24 - (yOffset ?? 0)) * GameScene.pixelSize - self.frame.height/2
            bottomY = -17 * GameScene.pixelSize + self.frame.height/2
        }
        
        let appear = SKAction.sequence(getAppearMoves(bottomY: bottomY))
        moveSequence = SKAction.sequence(getMoves(topY: topY, bottomY: bottomY))
        
        let seq = SKAction.sequence([appear])
        self.run(seq, completion: {() -> Void in
            if let moveSequence = self.moveSequence {
                let endlessMovement = SKAction.repeatForever(moveSequence)
                self.run(endlessMovement, withKey: "endlessMovement")
            }
        })
    }
    
    func computeNextRandomShotTime() {
        if let randomShootTimeIntervalRange = randomShootTimeIntervalRange {
            nextRandomShotTime = Date().addingTimeInterval(TimeInterval.random(in: randomShootTimeIntervalRange.min..<randomShootTimeIntervalRange.max))
        } else {
            nextRandomShotTime = nil
        }
    }
    
    func computeNextRandomMissleShotTime() {
        if let randomMissleShootTimeIntervalRange = randomMissleShootTimeIntervalRange {
            nextRandomMissleShotTime = Date().addingTimeInterval(TimeInterval.random(in: randomMissleShootTimeIntervalRange.min..<randomMissleShootTimeIntervalRange.max))
        } else {
            nextRandomMissleShotTime = nil
        }
    }
    
    func computeNextMinionSpawnTime() {
        if let minionSpawner = minionSpawner {
            nextMinionSpawnTime = Date().addingTimeInterval(TimeInterval.random(in: minionSpawner.min..<minionSpawner.max))
        } else {
            nextMinionSpawnTime = nil
        }
    }
    
    func getAppearMoves(bottomY: CGFloat) -> [SKAction] {
        var actions: [SKAction] = []
        let initialPosition = CGPoint(x: scene!.frame.maxX + self.frame.width/2, y: 0)
        actions.append(SKAction.move(to: initialPosition, duration: 0))
        
        let readyPosition = CGPoint(x: scene!.frame.maxX - self.frame.width/2 - 2 * GameScene.pixelSize, y: 0)
        let readyDistance = initialPosition.distance(point: readyPosition)
        let readyTime = readyDistance / bossSpeed
        actions.append(SKAction.move(to: readyPosition, duration: TimeInterval(readyTime)))
        
        let appeared: SKAction = SKAction.run {
            self.appeared = true
        }
        actions.append(appeared)
        
        let bottomPosition = CGPoint(x: scene!.frame.maxX - self.frame.width/2 - 2 * GameScene.pixelSize, y: bottomY)
        let bottomDistance = readyPosition.distance(point: bottomPosition)
        let bottomTime = bottomDistance / bossSpeed
        actions.append(SKAction.move(to: bottomPosition, duration: TimeInterval(bottomTime)))
        
        return actions
    }
    
    func getMoves(topY: CGFloat, bottomY: CGFloat) -> [SKAction] {
        var actions: [SKAction] = []
        
        let topPosition = CGPoint(x: scene!.frame.maxX - self.frame.width/2 - 2 * GameScene.pixelSize, y: topY)
        let bottomPosition = CGPoint(x: scene!.frame.maxX - self.frame.width/2 - 2 * GameScene.pixelSize, y: bottomY)
        
        
        let distance = topPosition.distance(point: bottomPosition)
        let time = distance / bossSpeed
        actions.append(SKAction.move(to: topPosition, duration: TimeInterval(time)))
        actions.append(SKAction.move(to: bottomPosition, duration: TimeInterval(time)))
        
        return actions
    }
    
    func getChargeMoves() -> [SKAction] {
        var actions: [SKAction] = []
        let initialPosition = self.position
        
        let hidePosition = CGPoint(x: scene!.frame.maxX + self.frame.width/2 + 1 * GameScene.pixelSize, y: initialPosition.y)
        let hideDistance = initialPosition.distance(point: hidePosition)
        let hideTime = hideDistance / bossSpeed

        let chargePosition = CGPoint(x: scene!.frame.minX + self.frame.width/2 + 1 * GameScene.pixelSize, y: initialPosition.y)
        let chargeDistance = initialPosition.distance(point: chargePosition)
        let chargeTime = chargeDistance / (bossSpeed * 5)
        
        let returnTime = chargeDistance / (bossSpeed * 2)
        
        if charge?.hideBefore == true {
            actions.append(SKAction.move(to: hidePosition, duration: TimeInterval(hideTime)))
        } else {
            actions.append(SKAction.wait(forDuration: 2))
        }
        actions.append(SKAction.move(to: chargePosition, duration: TimeInterval(chargeTime)))
        actions.append(SKAction.wait(forDuration: 1))
        actions.append(SKAction.move(to: initialPosition, duration: TimeInterval(returnTime)))
        
        return actions
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(damage: Int) {
        GameScene.score.addScore(value: damage*5)
        currentHealth -= damage
        blink()
        if currentHealth <= 0 {
            die()
        }
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
            self.run(seq)
        }
    }
    
    func die() {
        self.removeAllActions()
        spawnExplosions()
        
        self.removeFromParent()
        GameScene.interfaceDelegate.vibrate(.success)
        GameScene.score.addScore(value: score)
        
        if !GameScene.isRanked {
            removeAllBullets()
            removeAllEnemyMissles()
            removeAllMinions()
            
            GameScene.player.levelWinSequence()
        } else {
            RankedModeSpawner.pausedBecauseOfBoss = false
        }
        
        GameScene.boss = nil
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
    
    func removeAllBullets() {
        for (_, enemyBulletFromList) in GameScene.enemyBullets.enumerated() {
            enemyBulletFromList.removeSelf()
        }
    }
    
    func removeAllEnemyMissles() {
        for missleNuke in Nukes.missleNukes {
            if missleNuke.playerIsTarget == true {
                missleNuke.removeSelf()
            }
        }
    }
    
    func removeAllMinions() {
        for enemy in GameScene.enemies {
            if enemy.isMinion == true {
                enemy.removeSelf()
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
        
        if let nextRandomShotTime = self.nextRandomShotTime {
            if Date() > nextRandomShotTime {
                shoot()
                computeNextRandomShotTime()
            }
        }
        
        if let nextRandomMissleShotTime = self.nextRandomMissleShotTime {
            if Date() > nextRandomMissleShotTime {
                shootMissle()
                computeNextRandomMissleShotTime()
            }
        }
        
        if let nextMinionSpawnTime = self.nextMinionSpawnTime {
            if Date() > nextMinionSpawnTime {
                if !charging {
                    spawnMinion()
                }
                computeNextMinionSpawnTime()
            }
        }
        
        if let shootInterval = self.shootInterval {
            if Date() - lastPeriodicShotTime > shootInterval {
                lastPeriodicShotTime = Date()
                shoot()
            }
        }
        
        if let charge = self.charge {
            if Date() - lastChargeTime > charge.interval && !charging {
                doCharge()
            }
        }
    }
    
    func shootMissle() {
        let missle = instantiateMissle()
        
        let y = CGFloat.random(in: self.position.y - self.frame.height / 4 ... self.position.y + self.frame.height / 4)

        let misslePosition = CGPoint(x: self.position.x - frame.width/2 + missle.frame.width/2, y: y)
        missle.position = misslePosition
    }
    
    func spawnMinion() {
        if let minonSpawner = self.minionSpawner {
            let minion = Enemy()
            GameScene.enemies.append(minion)
            GameScene.scene.addChild(minion)
            
            let y = self.position.y
            
            var moves = [CGPoint(x: -48, y: y)]
            if minonSpawner.zigZag {
                if y < minion.frame.height/2 + 5 * GameScene.pixelSize {
                    moves = [CGPoint(x: 10, y: y), CGPoint(x: 0, y: y + 5), CGPoint(x: -16, y: y), CGPoint(x: -32, y: y + 5), CGPoint(x: -48, y: y)]
                } else {
                    moves = [CGPoint(x: 10, y: y), CGPoint(x: 0, y: y - 5), CGPoint(x: -16, y: y), CGPoint(x: -32, y: y - 5), CGPoint(x: -48, y: y)]
                }
            }
            
            minion.spawn(spriteOrAtlas: minonSpawner.spriteOrAtlas, health: minonSpawner.health, y: y, initialX: self.position.x - self.frame.width/2, moves: moves, enemySpeed: minonSpawner.minionSpeed, shootInterval: nil, randomShootTimeIntervalRange: nil, singleShootTimes: nil, score: minonSpawner.score, isMinion: true)
        }
    }
    
    func instantiateMissle() -> MissleNuke {
        let missleNuke = MissleNuke(playerIsTarget: true)
        Nukes.missleNukes.append(missleNuke)
        GameScene.scene.addChild(missleNuke)
        return missleNuke
    }
    
    func doCharge() {
        self.removeAction(forKey: "endlessMovement")
        charging = true
        
        let charge = SKAction.sequence(self.getChargeMoves())
        
        let seq = SKAction.sequence([charge])
        self.run(seq, completion: {() -> Void in
            self.lastChargeTime = Date()
            self.charging = false
            if let moveSequence = self.moveSequence {
                let endlessMovement = SKAction.repeatForever(moveSequence)
                self.run(endlessMovement, withKey: "endlessMovement")
            }
        })
    }
    
    func shoot() {
        let bullet = getBullet()
        let y = CGFloat.random(in: self.position.y - self.frame.height / 2 ... self.position.y + self.frame.height/2)

        let bulletPosition = CGPoint(x: self.position.x - self.frame.width/2 - bullet.frame.width/2, y: y)
        bullet.position = bulletPosition
        bullet.isHidden = false
        bullet.bulletSpeed = 35
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
