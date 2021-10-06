//
//  Score.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 04/12/2020.
//

import SpriteKit

class Score {
    
    var score = 0
       
    private var numbers: [SKSpriteNode] = []
    private var spriteAtlas: SKTextureAtlas

    init(initialScore: Int?) {
        spriteAtlas = SKTextureAtlas(named: "Numbers")
        instantiateNumbers()
        addScore(value: initialScore ?? 0)
    }
    
    func instantiateNumbers() {
        let firstFrame = spriteAtlas.textureNamed("frame0000")

        let sprite = firstFrame
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        for i in 0...4 {
            let number = SKSpriteNode(texture: sprite, color: GameScene.spriteColor, size: size)
            number.colorBlendFactor = 1
            
            var y :CGFloat = 0
            switch GameScene.hudPosition {
                case .top: y = 24 * GameScene.pixelSize - size.height / 2 - GameScene.pixelSize
                case .bottom: y = -24 * GameScene.pixelSize + size.height / 2 + GameScene.pixelSize
            }
            
            number.position = CGPoint(
                x: 48 * GameScene.pixelSize - size.width - GameScene.pixelSize - CGFloat(5 - i) * (size.width + GameScene.pixelSize),
                y: y
            )
            numbers.append(number)
            
            GameScene.scene.addChild(number)
        }
    }
    
    func addScore(value: Int) {
        score += value
        let scoreString = String(format: "%05d", score)
        for (index, letter) in scoreString.enumerated() {
            let spriteName = "frame000\(letter)"
            numbers[index].texture = spriteAtlas.textureNamed(spriteName)
        }
    }
    
}
