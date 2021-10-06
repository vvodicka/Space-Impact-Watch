//
//  GameScene.swift
//  Space Impact Shared
//
//  Created by Vladislav Vodicka on 25/11/2020.
//

import UIKit
import SpriteKit

enum HudPosition {
    case top
    case bottom
}

class GameScene: SKScene {
    
    static var player: Player!
    static var enemies: [Enemy] = []
    static var enemyBullets: [EnemyBullet] = []
    static var playerBullets: [PlayerBullet] = []
    static var nukes: Nukes!
    static var powerUps: [PowerUp] = []
    static var backgroundTiles: [BackgroundTile] = []
    static var boss: Boss?
    static var finalBoss: FinalBoss?
    private var currentLevel: [SpawnObject] = []
    private var currentSpawnIndex = 0
    private var dead = true
    static var level = 1
    
    private var hearts: [Heart] = []
    
    private let maxLives = 4
    private var lives = 3
    
    static var levelStartTime: TimeInterval = 0
    static var currentTime: TimeInterval = 0
    static var deltaTime: TimeInterval = 0
    static var pixelSize: CGFloat = 0
    static var spriteColor = hexStringToUIColor(hex: "#74AD8A")
    
    static var interfaceDelegate: InterfaceDelegate!
    
    static var scene: SKScene!
    static var score: Score!
    
    static var hudPosition: HudPosition = .top
    
    private var lastUpdateTime: TimeInterval = 0
    private var lastPauseTime: TimeInterval?
    private var totalPauseTime: TimeInterval = 0
    
    static let playerCategory: UInt32 = 0x1 << 0
    static let enemyCategory: UInt32 = 0x1 << 1
    static let powerUpCategory: UInt32 = 0x1 << 2
    static let playerBulletCategory: UInt32 = 0x1 << 3
    static let missleNukeCategory: UInt32 = 0x1 << 4
    static let enemyBulletCategory: UInt32 = 0x1 << 5
    static let bossCategory: UInt32 = 0x1 << 6
    
    private var gameControllerDelegate: GameControllerDelegate!
    
    static var isRanked : Bool = false
    var rankedModeSpawner = RankedModeSpawner()
    
    class func newGameScene(interfaceDelegate: InterfaceDelegate, view: CGRect, gameControllerDelegate: GameControllerDelegate, level: Int?, initialScore: Int?) -> GameScene {
        GameScene.isRanked = false
        
        GameScene.level = level ?? 1
        GameScene.spriteColor = GameScene.hasBlackBackground() ? hexStringToUIColor(hex: "#74AD8A") : hexStringToUIColor(hex: "#000000")
        
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.gameControllerDelegate = gameControllerDelegate
        
        GameScene.interfaceDelegate = interfaceDelegate
        scene.scaleMode = .aspectFit
        
        GameScene.score = Score(initialScore: initialScore)
        
        return scene
    }
    
    class func newRankedGameScene(interfaceDelegate: InterfaceDelegate, view: CGRect, gameControllerDelegate: GameControllerDelegate) -> GameScene {
        GameScene.isRanked = true
        
        GameScene.spriteColor = hexStringToUIColor(hex: "#74AD8A")
        
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.gameControllerDelegate = gameControllerDelegate
        
        GameScene.interfaceDelegate = interfaceDelegate
        scene.scaleMode = .aspectFit
        
        GameScene.score = Score(initialScore: 0)
        
        return scene
    }
    
    func setUpScene(level: [SpawnObject]?) {
        GameScene.pixelSize = scene!.frame.width/84
        switch GameScene.level {
        case 5, 6:
            GameScene.hudPosition = .bottom
        default:
            GameScene.hudPosition = .top
        }
        
        instantiateBackground()
        instantiatePlayer()
        GameScene.nukes = Nukes(nuke: (type: .missle, count: 3))
        renderHud()
        if let level = level {
            currentLevel = level
        }
        currentSpawnIndex = 0
        
        dead = false
    }
    
    func renderHud() {
        renderHearts()
    }
    
    static func hasBlackBackground() -> Bool {
        if isRanked {
            return true
        }
        return [1, 5].contains(GameScene.level)
    }
    
    func instantiateBackground() {
        if GameScene.hasBlackBackground() {
            let rect = SKSpriteNode()
            rect.size = CGSize(width: 84 * GameScene.pixelSize, height: 48 * GameScene.pixelSize)
            rect.color = hexStringToUIColor(hex: "#000000")
            scene!.addChild(rect)
        }
        
        var tileTexture: SKTexture?
        
        if !GameScene.isRanked {
            switch GameScene.level {
            case 2:
                tileTexture = SKTexture(imageNamed: "background1")
            case 3:
                tileTexture = SKTexture(imageNamed: "background2")
            case 4:
                tileTexture = SKTexture(imageNamed: "background3")
            case 5:
                tileTexture = SKTexture(imageNamed: "background4")
            case 6:
                tileTexture = SKTexture(imageNamed: "background4")
            case 7:
                tileTexture = SKTexture(imageNamed: "background5")
            case 8:
                tileTexture = SKTexture(imageNamed: "background6")
            default: return
            }
        }
        
        if let tileTexture = tileTexture {
            for index in 0...1 {
                let backgroundTile = BackgroundTile()
                let width = tileTexture.size().width/10 * GameScene.pixelSize
                let x = GameScene.scene.frame.minX + width/2 + CGFloat(index)*width
                backgroundTile.spawn(sprite: tileTexture, x: x)
                GameScene.backgroundTiles.append(backgroundTile)
                scene!.addChild(backgroundTile)
            }
        }
    }
    
    override func sceneDidLoad() {
        GameScene.scene = scene
        
        self.setUpScene(level: getLevelSpawns())
    }
    
    func instantiatePlayer() {
        GameScene.player = Player(self)
        scene?.addChild(GameScene.player)
        GameScene.player.spawn()
    }
    
    func instantiateEnemy(spriteOrAtlas: String, health: Int, y: CGFloat, moves: [CGPoint], enemySpeed: CGFloat, shootInterval: TimeInterval?, singleShootTimes: [TimeInterval]?, randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, score: Int) {
        var enemy: Enemy?
        for pooledEnemy in GameScene.enemies {
            if pooledEnemy.isHidden {
                enemy = pooledEnemy
            }
        }
        if enemy == nil {
            enemy = Enemy()
            GameScene.enemies.append(enemy!)
            scene?.addChild(enemy!)
        }
        enemy!.spawn(spriteOrAtlas: spriteOrAtlas, health: health, y: y, moves: moves, enemySpeed: enemySpeed, shootInterval: shootInterval, randomShootTimeIntervalRange: randomShootTimeIntervalRange, singleShootTimes: singleShootTimes, score: score)
    }
    
    func instantateBoss(spriteOrAtlas: String, bossSpeed: CGFloat, health: Int, score: Int, shootInterval: TimeInterval?, randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, singleShootTimes: [TimeInterval]?, yOffset: Int?, charge: (interval: TimeInterval, hideBefore: Bool)?, randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?, minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)?) {
        let boss = Boss()
        GameScene.boss = boss
        scene?.addChild(boss)
        boss.spawn(spriteOrAtlas: spriteOrAtlas, bossSpeed: bossSpeed, health: health, score: score, shootInterval: shootInterval, randomShootTimeIntervalRange: randomShootTimeIntervalRange, singleShootTimes: singleShootTimes, yOffset: yOffset, charge: charge, randomMissleShootTimeIntervalRange: randomMissleShootTimeIntervalRange, minionSpawner: minionSpawner)
    }
    
    func instantateFinalBoss(spriteOrAtlas: String, bossSpeed: CGFloat, health: Int, score: Int, randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)?) {
        let finalBoss = FinalBoss()
        GameScene.finalBoss = finalBoss
        scene?.addChild(finalBoss)
        finalBoss.spawn(spriteOrAtlas: spriteOrAtlas, bossSpeed: bossSpeed, health: health, score: score, randomMissleShootTimeIntervalRange: randomMissleShootTimeIntervalRange)
    }
    
    func instantiatePowerUp(spriteOrAtlas: String, y: CGFloat, moves: [CGPoint], powerUpSpeed: CGFloat) {
        let powerUp = PowerUp()
        GameScene.powerUps.append(powerUp)
        scene?.addChild(powerUp)
        powerUp.spawn(spriteOrAtlas: spriteOrAtlas, y: y, moves: moves, powerUpSpeed: powerUpSpeed)
    }
    
    func renderHearts() {
        if hearts.count == 0 {
            for i in 0...maxLives - 1 {
                let heart = Heart(name: "heart\(i)")
                let x = scene!.frame.minX + heart.frame.width/2 + GameScene.pixelSize + CGFloat(i) * (heart.frame.width + GameScene.pixelSize)
                
                var y :CGFloat = 0
                switch GameScene.hudPosition {
                case .top: y = 24 * GameScene.pixelSize - heart.frame.height/2 - GameScene.pixelSize
                case .bottom: y = -24 * GameScene.pixelSize + heart.frame.height/2 + GameScene.pixelSize
                }
                
                heart.position = CGPoint(x: x, y: y)
                hearts.append(heart)
                scene?.addChild(heart)
            }
        }
        
        for i in 0...maxLives - 1 {
            let heart = hearts[i]
            heart.isHidden = i > lives - 1
        }
    }
    
    func removeLife() {
        lives -= 1
        if lives > 0 {
            renderHearts()
        } else {
            gameOver(victory: false)
        }
    }
    
    func addLife() {
        if lives < 4 {
            lives += 1
        }
        renderHearts()
    }
    
    func clearLevel() {
        dead = true
        var childrenToRemove: [SKNode] = []
        for child in scene?.children ?? [] {
            if child.name != "nokia" {
                childrenToRemove.append(child)
            }
        }
        scene?.removeChildren(in: childrenToRemove)
        GameScene.enemies = []
        GameScene.powerUps = []
        GameScene.playerBullets = []
        GameScene.enemyBullets = []
        GameScene.backgroundTiles = []
        hearts = []
        GameScene.levelStartTime = 0
        GameScene.boss = nil
        GameScene.finalBoss = nil
        RankedModeSpawner.pausedBecauseOfBoss = false
    }
    
    func loadLevel(level: Int, scoreToKeep: Int? = nil) {
        clearLevel()
        gameControllerDelegate.loadLevel(context : (scoreToKeep ?? 0, level))
    }
    
    func gameOver(victory: Bool) {
        clearLevel()
        gameControllerDelegate.presentGameOverController(context: (score : GameScene.score.score, level: GameScene.level, victory: victory, ranked: GameScene.isRanked))
    }
    
    func getLevelSpawns() -> [SpawnObject]? {
        if GameScene.isRanked {
            return nil
        }
        
        switch GameScene.level {
        case 1: return Levels.level1
        case 2: return Levels.level2
        case 3: return Levels.level3
        case 4: return Levels.level4
        case 5: return Levels.level5
        case 6: return Levels.level6
        case 7: return Levels.level7
        case 8: return Levels.level8
        default: return Levels.level1
        }
    }
    
    func setLastPauseTime() {
        lastPauseTime = lastUpdateTime
    }
    
    func onResume() {
        if let lastPauseTime = self.lastPauseTime {
            totalPauseTime += GameScene.currentTime  - lastPauseTime
            self.lastPauseTime = nil
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if dead {
            return
        }
        
        GameScene.currentTime = currentTime
        
        if lastPauseTime != nil {
            return
        }
        
        if GameScene.levelStartTime == 0 {
            GameScene.levelStartTime = currentTime
        }
        
        GameScene.deltaTime = currentTime - lastUpdateTime
        
        if GameScene.deltaTime > 1 {
            GameScene.deltaTime = 1/60
        }
        lastUpdateTime = currentTime
        
        if scene == nil || lives <= 0 {
            return
        }
        
        GameScene.player.update()
        GameScene.nukes.update()
        
        let inLevelTime = currentTime - GameScene.levelStartTime - totalPauseTime
        
        for playerBullet in GameScene.playerBullets {
            playerBullet.update()
        }
        
        for enemy in GameScene.enemies {
            enemy.update(inLevelTime: inLevelTime)
        }
        
        for enemyBullet in GameScene.enemyBullets {
            enemyBullet.update()
        }
        
        for powerUp in GameScene.powerUps {
            powerUp.update()
        }
        
        for backgroundTitle in GameScene.backgroundTiles {
            if GameScene.boss?.appeared == true || GameScene.finalBoss?.appeared == true || GameScene.player.endGame {
                continue
            }
            backgroundTitle.update()
        }
        
        if let boss = GameScene.boss {
            boss.update(inLevelTime: inLevelTime)
        }
        
        if let finalBoss = GameScene.finalBoss {
            finalBoss.update(inLevelTime: inLevelTime)
        }
        
        checkCollisions()
        
        if currentSpawnIndex < currentLevel.count {
            for index in currentSpawnIndex ... currentLevel.count-1 {
                let spawnObject = currentLevel[index]
                if inLevelTime > spawnObject.time {
                    currentSpawnIndex+=1
                    switch spawnObject.type {
                    case .enemy: instantiateEnemy(spriteOrAtlas: spawnObject.spriteOrAtlas, health: spawnObject.health!, y: spawnObject.y!, moves: spawnObject.moves!, enemySpeed: spawnObject.speed, shootInterval: spawnObject.shootInterval, singleShootTimes: spawnObject.singleShootTimes, randomShootTimeIntervalRange: spawnObject.randomShootTimeIntervalRange, score: spawnObject.score!)
                    case .powerUp: instantiatePowerUp(spriteOrAtlas: spawnObject.spriteOrAtlas,y: spawnObject.y!, moves: spawnObject.moves!, powerUpSpeed: spawnObject.speed)
                    case .boss: instantateBoss(spriteOrAtlas: spawnObject.spriteOrAtlas, bossSpeed: spawnObject.speed, health: spawnObject.health!, score: spawnObject.score!, shootInterval: spawnObject.shootInterval, randomShootTimeIntervalRange: spawnObject.randomShootTimeIntervalRange, singleShootTimes: spawnObject.singleShootTimes, yOffset: spawnObject.yOffset, charge: spawnObject.charge, randomMissleShootTimeIntervalRange: spawnObject.randomMissleShootTimeIntervalRange, minionSpawner: spawnObject.minionSpawner)
                    case .finalBoss: instantateFinalBoss(spriteOrAtlas: spawnObject.spriteOrAtlas, bossSpeed: spawnObject.speed, health: spawnObject.health!, score: spawnObject.score!, randomMissleShootTimeIntervalRange: spawnObject.randomMissleShootTimeIntervalRange)
                    }
                }
            }
        }
        
        if GameScene.isRanked && GameScene.boss == nil {
            let spawns = rankedModeSpawner.getSpawns(inLevelTime: inLevelTime)
            
            if currentSpawnIndex <= spawns.count - 1 {
                for index in currentSpawnIndex ... spawns.count-1 {
                    let spawnObject = spawns[index]
                    if inLevelTime > spawnObject.time {
                        currentSpawnIndex+=1
                        switch spawnObject.type {
                        case .enemy: instantiateEnemy(spriteOrAtlas: spawnObject.spriteOrAtlas, health: spawnObject.health!, y: spawnObject.y!, moves: spawnObject.moves!, enemySpeed: spawnObject.speed, shootInterval: spawnObject.shootInterval, singleShootTimes: spawnObject.singleShootTimes, randomShootTimeIntervalRange: spawnObject.randomShootTimeIntervalRange, score: spawnObject.score!)
                        case .powerUp: instantiatePowerUp(spriteOrAtlas: spawnObject.spriteOrAtlas,y: spawnObject.y!, moves: spawnObject.moves!, powerUpSpeed: spawnObject.speed)
                        case .boss: instantateBoss(spriteOrAtlas: spawnObject.spriteOrAtlas, bossSpeed: spawnObject.speed, health: spawnObject.health!, score: spawnObject.score!, shootInterval: spawnObject.shootInterval, randomShootTimeIntervalRange: spawnObject.randomShootTimeIntervalRange, singleShootTimes: spawnObject.singleShootTimes, yOffset: spawnObject.yOffset, charge: spawnObject.charge, randomMissleShootTimeIntervalRange: spawnObject.randomMissleShootTimeIntervalRange, minionSpawner: spawnObject.minionSpawner)
                        default: break
                        }
                    }
                }
            }
        }
    }
    
    func checkCollisions() {
        //player vs enemy
        for enemy in GameScene.enemies {
            if !enemy.isHidden && GameScene.player.frame.intersects(enemy.frame) {
                GameScene.player.hit()
                enemy.die()
            }
        }
        
        //player vs boss
        if let boss = GameScene.boss {
            if !boss.isHidden && GameScene.player.frame.intersects(boss.frame) && !GameScene.player.immortal {
                GameScene.player.hit()
                boss.hit(damage: 1)
            }
        }
        
        //player vs missle
        for missleNuke in Nukes.missleNukes {
            if !missleNuke.isHidden && GameScene.player.frame.intersects(missleNuke.frame) && missleNuke.playerIsTarget == true {
                missleNuke.removeSelf()
                GameScene.player.hit()
            }
        }
        
        //player vs enemy bullet
        for enemyBullet in GameScene.enemyBullets {
            if !enemyBullet.isHidden && GameScene.player.frame.intersects(enemyBullet.frame) {
                enemyBullet.removeSelf()
                if !GameScene.player.immortal {
                    GameScene.player.hit()
                }
            }
        }
        
        //player vs powerup
        for powerUp in GameScene.powerUps {
            if !powerUp.isHidden && GameScene.player.frame.intersects(powerUp.frame) {
                powerUp.collect()
            }
        }
        
        //enemy vs player bullet
        for enemy in GameScene.enemies {
            for playerBullet in GameScene.playerBullets {
                if !enemy.isHidden && !playerBullet.isHidden && enemy.frame.intersects(playerBullet.frame) {
                    playerBullet.removeSelf()
                    enemy.hit(damage: 1)
                }
            }
        }
        
        //enemy bullet vs player bullet
        for enemyBullet in GameScene.enemyBullets {
            for playerBullet in GameScene.playerBullets {
                if !enemyBullet.isHidden && !playerBullet.isHidden && enemyBullet.frame.intersects(playerBullet.frame) {
                    GameScene.score.addScore(value: 5)
                    enemyBullet.removeSelf()
                    playerBullet.removeSelf()
                    Explosion(position: enemyBullet.position, size: .small)
                }
            }
        }
        
        //enemy missle vs player bullet
        for missle in Nukes.missleNukes {
            if missle.playerIsTarget == true {
                for playerBullet in GameScene.playerBullets {
                    if !missle.isHidden && !playerBullet.isHidden && missle.frame.intersects(playerBullet.frame) {
                        GameScene.score.addScore(value: 5)
                        missle.removeSelf()
                        playerBullet.removeSelf()
                        Explosion(position: missle.position, size: .small)
                    }
                }
            }
        }
        
        //enemy vs missle
        for enemy in GameScene.enemies {
            for missleNuke in Nukes.missleNukes {
                if !enemy.isHidden && !missleNuke.isHidden && enemy.frame.intersects(missleNuke.frame) && missleNuke.playerIsTarget == false {
                    missleNuke.removeSelf()
                    enemy.hit(damage: missleNuke.damage)
                }
            }
        }
        
        //player bullet vs powerup
        for powerUp in GameScene.powerUps {
            for playerBullet in GameScene.playerBullets {
                if !powerUp.isHidden && !playerBullet.isHidden && powerUp.frame.intersects(playerBullet.frame) {
                    playerBullet.removeSelf()
                }
            }
        }
        
        //boss vs missle
        if let boss = GameScene.boss {
            for missleNuke in Nukes.missleNukes {
                if !missleNuke.isHidden && boss.frame.intersects(missleNuke.frame) && missleNuke.playerIsTarget == false {
                    missleNuke.removeSelf()
                    boss.hit(damage: missleNuke.damage)
                }
            }
        }
        
        //boss vs player bullet
        if let boss = GameScene.boss {
            for playerBullet in GameScene.playerBullets {
                if !playerBullet.isHidden && boss.frame.intersects(playerBullet.frame) {
                    playerBullet.removeSelf()
                    boss.hit(damage: 1)
                }
            }
        }
        
        //player vs finall boss tentacle
        if let finalBoss = GameScene.finalBoss {
            for tenacle in finalBoss.tentacles {
                if !tenacle.isHidden && GameScene.player.frame.intersects(tenacle.frame) {
                    GameScene.player.hit()
                }
            }
        }
    }
    
}

