//
//  MissleNuke.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 07/12/2020.
//

import SpriteKit

class MissleNuke : SKSpriteNode {
    
    let nukeSpeed: CGFloat = 30
    let damage: Int = 5
    
    var playerIsTarget : Bool?
    
    init(playerIsTarget : Bool? = false) {
        self.playerIsTarget = playerIsTarget
        
        let sprite = SKTexture(imageNamed: "nuke_missle")
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        super.init(texture: sprite, color: GameScene.spriteColor, size: size)
        self.colorBlendFactor = 1
        
        self.xScale = playerIsTarget == true ? -1 : 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        if let scene = scene, !isHidden {
            if playerIsTarget == true {
                self.position.x -= nukeSpeed * CGFloat(GameScene.deltaTime)
                
                let playerPosition = GameScene.player.position
                
                if abs(playerPosition.y - self.position.y) > self.frame.height {
                    let direction = (playerPosition.y - self.position.y) / abs(playerPosition.y - self.position.y)
                    self.position.y += direction * nukeSpeed * CGFloat(GameScene.deltaTime)
                }
                
                if self.position.x < scene.frame.minX {
                    removeSelf()
                }
            } else {
                self.position.x += nukeSpeed * CGFloat(GameScene.deltaTime)
                if let nearestEnemyPosition = getNearestEnemyPosition(), abs(nearestEnemyPosition.y - self.position.y) > self.frame.height {
                    let direction = (nearestEnemyPosition.y - self.position.y) / abs(nearestEnemyPosition.y - self.position.y)
                    self.position.y += direction * nukeSpeed * CGFloat(GameScene.deltaTime)
                }
                
                if self.position.x > scene.frame.maxX {
                    removeSelf()
                }
            }
        }
    }
    
    func removeSelf() {
        self.isHidden = true
    }
    
    func getNearestEnemyPosition() -> CGPoint? {
        var nearestDistance: CGFloat = CGFloat.infinity
        var nearestEnemy: Enemy?
        
        for enemy in GameScene.enemies {
            let distance =  self.position.distance(point: enemy.getPosition())
            if distance < nearestDistance {
                nearestDistance = self.position.distance(point: enemy.getPosition())
                nearestEnemy = enemy
            }
        }
        
        if let boss = GameScene.boss {
            let bossDistance = self.position.distance(point: boss.getPosition())
            if  bossDistance < nearestDistance {
                return boss.getPosition()
            }
        }
        
        if let finalBoss = GameScene.finalBoss {
            if let eyeCollider = finalBoss.eyeCollider {
                let eyeColliderDistance = self.position.distance(point: eyeCollider.position)
                if  eyeColliderDistance < nearestDistance {
                    return eyeCollider.position
                }
            } else {
                for tentacle in finalBoss.tentacles {
                    if tentacle.currentHealth > 0 {
                        let tentacleDistance = self.position.distance(point: tentacle.getPosition())
                        if  tentacleDistance < nearestDistance {
                            return tentacle.getPosition()
                        }
                    }
                }
            }
            
        }
        
        return nearestEnemy?.getPosition()
    }
}

