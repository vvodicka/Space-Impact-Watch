//
//  LaserNuke.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 08/12/2020.
//

import SpriteKit

class LaserNuke : SKSpriteNode {
    
    let damage: Int = 5
    var beam: SKSpriteNode!
    
    private var spawnTime: TimeInterval = 0
    private var duration: TimeInterval = 0.6
    
    var bossHit = false
    var enemiesHit: [UUID] = []
    
    init() {
        let sprite = SKTexture(imageNamed: "nuke_laser_effect")
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        
        beam = SKSpriteNode()
        beam.size = CGSize(width: 63 * GameScene.pixelSize, height: GameScene.pixelSize)
        beam.color = GameScene.spriteColor
        beam.position = CGPoint(x: 11 * GameScene.pixelSize, y: self.position.y)
        beam.isHidden = true
        GameScene.scene.addChild(beam)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawn() {
        self.spawnTime = GameScene.currentTime
        
        enemiesHit = []
        bossHit = false

        let showEffect: SKAction = SKAction.run {
            self.isHidden = false
        }
        
        let wait: SKAction = SKAction.wait(forDuration: 0.1)
        
        let showBeam: SKAction = SKAction.run {
            self.beam.isHidden = false
        }
        
        let seq = SKAction.sequence([showEffect, wait, showBeam])
        self.run(seq)
    }
    
    func removeSelf() {
        for (index, laserNuke) in Nukes.laserNukes.enumerated() {
            if laserNuke == self {
                Nukes.laserNukes.remove(at: index)
            }
        }
        self.removeFromParent()
        self.beam.removeFromParent()
    }
    
    func update() {
        if GameScene.currentTime - spawnTime > duration {
            removeSelf()
        }
        
        self.position.y = GameScene.player.position.y
        self.beam.position.y = GameScene.player.position.y
        checkCollisions()
    }
    
    func checkCollisions() {
        for enemy in GameScene.enemies {
            if !enemiesHit.contains(enemy.id) && !enemy.isHidden && (self.frame.intersects(enemy.getSKSpriteNode().frame) || (!self.beam.isHidden && self.beam.frame.intersects(enemy.getSKSpriteNode().frame))) {
                enemiesHit.append(enemy.id)
                enemy.hit(damage: damage)
            }
        }
        
        for enemyBullet in GameScene.enemyBullets {
            if !enemyBullet.isHidden && (self.frame.intersects(enemyBullet.frame) || (!self.beam.isHidden && self.beam.frame.intersects(enemyBullet.frame))) {
                GameScene.score.addScore(value: 5)
                enemyBullet.removeSelf()
                Explosion(position: enemyBullet.position, size: .small)
            }
        }
        
        for enemyMissle in Nukes.missleNukes {
            if !enemyMissle.isHidden && (self.frame.intersects(enemyMissle.frame) || (!self.beam.isHidden && self.beam.frame.intersects(enemyMissle.frame)) && enemyMissle.playerIsTarget == true) {
                GameScene.score.addScore(value: 5)
                enemyMissle.removeSelf()
                Explosion(position: enemyMissle.position, size: .small)
            }
        }
        
        if let boss = GameScene.boss {
            if !bossHit && (self.frame.intersects(boss.getSKSpriteNode().frame) || (!self.beam.isHidden && self.beam.frame.intersects(boss.getSKSpriteNode().frame))) {
                bossHit = true
                boss.hit(damage: damage)
            }
        }
        
        if let finalBoss = GameScene.finalBoss {
            for tentacle in finalBoss.tentacles {
                if !enemiesHit.contains(tentacle.id) && !tentacle.isHidden && (self.frame.intersects(tentacle.getSKSpriteNode().frame) || (!self.beam.isHidden && self.beam.frame.intersects(tentacle.getSKSpriteNode().frame))) {
                    enemiesHit.append(tentacle.id)
                    tentacle.hit(damage: 5)
                }
            }
            
            if let eyeCollider = finalBoss.eyeCollider {
                if !bossHit && (self.frame.intersects(eyeCollider.frame) || (!self.beam.isHidden && self.beam.frame.intersects(eyeCollider.frame)) && !finalBoss.megaSpawning) {
                    bossHit = true
                    GameScene.score.addScore(value: 5)
                    finalBoss.hit(damage: 5)
                }
            }
        }
    }
    
}


