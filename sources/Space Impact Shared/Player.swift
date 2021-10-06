//
//  Player.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 30/11/2020.
//

import SpriteKit

class Player : SKSpriteNode {
        
    var lastShoot: TimeInterval = 0
    var shootSpeed: TimeInterval = 0.4
    
    let playerSpeed : CGFloat = 30
    var immortal: Bool = true
    var hitImmortalityTime: TimeInterval = 2
    var lastHitTime: TimeInterval = 0
    
    private var immortalFrames: [SKTexture] = []
    private var immortalityBubble: SKSpriteNode!
    
    private var gameScene: GameScene!
    var endGame = false
    
    private var defaults: UserDefaults!
    
    init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        let sprite = SKTexture(imageNamed: "player")
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        self.name = "player"
        
        if GameScene.level ?? 0 > 3 {
            shootSpeed = 0.3
        }
        
        defaults = UserDefaults.standard
    }
    
    func spawn() {
        position.x = scene!.frame.minX + frame.width/2 + 2 * GameScene.pixelSize
        for _ in 0...20 {
            instantiateBullet()
        }
        lastHitTime = GameScene.currentTime
        instantiateImmortalityBubble()
    }
    
    func instantiateBullet() -> PlayerBullet {
        let bullet = PlayerBullet()
        GameScene.playerBullets.append(bullet)
        scene?.addChild(bullet)
        return bullet
    }
    
    func instantiateImmortalityBubble() {
        let spriteAtlas = SKTextureAtlas(named: "PlayerImmortalityBubble")
        var frames: [SKTexture] = []
        let numImages = spriteAtlas.textureNames.count
          for i in 0...numImages - 1 {
            let spriteName = "frame000\(i)"
            frames.append(spriteAtlas.textureNamed(spriteName))
          }
        
        let sprite = frames[0]
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        immortalityBubble = SKSpriteNode(texture: sprite, color: GameScene.spriteColor, size: size)
        immortalityBubble.colorBlendFactor = 1
        self.addChild(immortalityBubble)
        
        immortalityBubble.run(SKAction.repeatForever(
        SKAction.animate(with: frames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true))
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movePlayer(rotationalDelta: CGFloat) {
        if self.isHidden {
            return
        }
        
        let sensitivity = defaults.float(forKey: "sensitivity")
        let invertedControls = defaults.bool(forKey: "invertedControls")
        let invert : CGFloat = invertedControls ? -1 : 1

        
        let finalPlayerSpeed = playerSpeed + CGFloat(sensitivity * 10)
        
        self.position.y += rotationalDelta * finalPlayerSpeed * invert
        let playerHeight = self.frame.height
        
        switch GameScene.hudPosition {
            case .top:
                self.position.y = min(self.position.y, 17 * GameScene.pixelSize - playerHeight/2) //HUD ma 5px + 2 padding
                self.position.y = max(self.position.y, -22 * GameScene.pixelSize + playerHeight/2)
            case .bottom:
                self.position.y = min(self.position.y, 22 * GameScene.pixelSize - playerHeight/2)
                self.position.y = max(self.position.y, -17 * GameScene.pixelSize + playerHeight/2) //HUD ma 5px + 2 padding
        }
    }
    
    func fireNuke() {
        if self.isHidden {
            return
        }
        
        GameScene.nukes.fireNuke()
    }
    
    func shoot() {
        if GameScene.currentTime - lastShoot > shootSpeed && !self.isHidden {
            lastShoot = GameScene.currentTime
            let bullet = getBullet()
            let bulletPosition = CGPoint(x: self.position.x + self.frame.width/2 + bullet.frame.width/2, y: self.position.y)
            bullet.position = bulletPosition
            bullet.isHidden = false
        }
    }
    
    func getBullet() -> PlayerBullet {
        for bullet in GameScene.playerBullets {
            if bullet.isHidden {
                return bullet
            }
        }
        return instantiateBullet()
    }
    
    func update() {
        if endGame {
            return
        }
        shoot()
                
        if immortal && GameScene.currentTime - lastHitTime > hitImmortalityTime {
            immortal = false
            immortalityBubble.isHidden = true
        }
    }
    
    func hit() {
        if !immortal && !self.isHidden {
            let explode: SKAction = SKAction.run {
                self.isHidden = true
                Explosion(position: self.position, size: .big)
            }
            
            let wait: SKAction = SKAction.wait(forDuration: 0.3)
            
            let respawn: SKAction = SKAction.run {
                self.isHidden = false
                self.position.y = 0
                self.immortal = true
                self.lastHitTime = GameScene.currentTime
                self.immortalityBubble.isHidden = false
            }
            
            let seq = SKAction.sequence([explode, wait, respawn])
            self.run(seq)
            
            GameScene.interfaceDelegate.vibrate(.notification)
            gameScene.removeLife()
        }
    }
    
    func heal() {
        gameScene.addLife()
    }
        
    func levelWinSequence() {
        defaults.set(true, forKey: "level\(GameScene.level + 1)Unlocked")

        endGame = true
        var targetY : CGFloat = 0
        switch GameScene.hudPosition {
            case .top:
                targetY = 17 * GameScene.pixelSize - self.frame.height/2
            case .bottom:
                targetY = -17 * GameScene.pixelSize + self.frame.height/2
        }
        
        var actions: [SKAction] = []
    
        actions.append(SKAction.move(to: CGPoint(x: scene!.frame.minX + frame.width/2 + 2 * GameScene.pixelSize, y: targetY), duration: 1))
        actions.append(SKAction.move(to: CGPoint(x: -10 * GameScene.pixelSize, y: targetY), duration: 0.5))
        actions.append(SKAction.move(to: CGPoint(x: scene!.frame.maxX + scene!.frame.maxX/3 + self.frame.width/2, y: targetY), duration: 0.5))

        let endLevel: SKAction = SKAction.run {
            if GameScene.level < 8 {
                self.gameScene.loadLevel(level: GameScene.level + 1, scoreToKeep: GameScene.score.score)
            } else {
                self.gameScene.gameOver(victory: true)
            }
        }
        actions.append(endLevel)

        let seq: SKAction = SKAction.sequence(actions)
        self.run(seq)
    }
}
