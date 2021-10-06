//
//  LineNuke.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 04/12/2020.
//

import SpriteKit

class LineNuke : SKNode {
    
    let damage: Int = 5
    let nukeSpeed: CGFloat = 30
    
    var sprite: SKSpriteNode!
    
    var bossHit = false
    var enemiesHit: [UUID] = []
    
    override init() {
        sprite = SKSpriteNode()
        sprite.size = CGSize(width: GameScene.pixelSize * 2, height: 41 * GameScene.pixelSize)
        sprite.color = GameScene.spriteColor
        super.init()
        
        var y :CGFloat = 0
        switch GameScene.hudPosition {
            case .top: y = -3.75 * GameScene.pixelSize
            case .bottom: y = 3.75 * GameScene.pixelSize
        }
                
        sprite.position = CGPoint(x: GameScene.player.position.x + GameScene.player.frame.width/2 + GameScene.pixelSize, y: y)
        GameScene.scene.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        sprite.position.x += nukeSpeed * CGFloat(GameScene.deltaTime)
        
        if sprite.position.x > GameScene.scene.frame.maxX {
            removeSelf()
        }
        
        checkCollisions()
    }
    
    func removeSelf() {
        for (index, lineNuke) in Nukes.lineNukes.enumerated() {
            if self == lineNuke {
                Nukes.lineNukes.remove(at: index)
            }
        }
        self.sprite.removeFromParent()
        self.removeFromParent()
    }
    
    func checkCollisions() {
        for enemy in GameScene.enemies {
            if !enemiesHit.contains(enemy.id) && !enemy.isHidden && sprite.frame.intersects(enemy.getSKSpriteNode().frame) {
                enemiesHit.append(enemy.id)
                GameScene.score.addScore(value: 5)
                enemy.hit(damage: 5)
            }
        }
        
        for enemyBullet in GameScene.enemyBullets {
            if !enemyBullet.isHidden && sprite.frame.intersects(enemyBullet.frame) {
                GameScene.score.addScore(value: 5)
                enemyBullet.removeSelf()
                Explosion(position: enemyBullet.position, size: .small)
            }
        }
        
        for enemyMissle in Nukes.missleNukes {
            if !enemyMissle.isHidden && sprite.frame.intersects(enemyMissle.frame) && enemyMissle.playerIsTarget == true {
                GameScene.score.addScore(value: 5)
                enemyMissle.removeSelf()
                Explosion(position: enemyMissle.position, size: .small)
            }
        }
        
        if let boss = GameScene.boss {
            if !bossHit && sprite.frame.intersects(boss.getSKSpriteNode().frame) {
                bossHit = true
                GameScene.score.addScore(value: 5)
                boss.hit(damage: 5)
            }
        }
        
        if let finalBoss = GameScene.finalBoss {
            for tentacle in finalBoss.tentacles {
                if !enemiesHit.contains(tentacle.id) && !tentacle.isHidden && sprite.frame.intersects(tentacle.getSKSpriteNode().frame) {
                    enemiesHit.append(tentacle.id)
                    tentacle.hit(damage: 5)
                }
            }
            
            if let eyeCollider = finalBoss.eyeCollider {
                if !bossHit && sprite.frame.intersects(eyeCollider.frame) && !finalBoss.megaSpawning {
                    bossHit = true
                    GameScene.score.addScore(value: 5)
                    finalBoss.hit(damage: 5)
                }
            }
        }
    }
    
}
