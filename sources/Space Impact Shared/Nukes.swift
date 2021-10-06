//
//  Nukes.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 04/12/2020.
//

import SpriteKit

class Nukes {
        
    static var currentNukes: (type: NukeType, count: Int) = (type: .missle, count: 3)
    
    private var nukeIcon: SKSpriteNode?
    private var numbers: [SKSpriteNode] = []
    private var spriteAtlas: SKTextureAtlas
    
    static var lineNukes: [LineNuke] = []
    static var missleNukes: [MissleNuke] = []
    static var laserNukes: [LaserNuke] = []
    
    init(nuke: (type: NukeType, count: Int)) {
        spriteAtlas = SKTextureAtlas(named: "Numbers")
        instantiateNumbers()
        instantiateHud()
        Nukes.currentNukes = nuke
        renderNukesHud()
    }
    
    func instantiateHud() {
        
        let sprite = getNukeIcon()
        
        if let nukeIcon = nukeIcon {
            nukeIcon.texture = sprite
        } else {
            let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
            let newNukeIcon = SKSpriteNode(texture: sprite, color: GameScene.spriteColor, size: size)
            
            var y :CGFloat = 0
            switch GameScene.hudPosition {
                case .top: y = 24 * GameScene.pixelSize - size.height / 2 - GameScene.pixelSize
                case .bottom: y = -24 * GameScene.pixelSize + size.height / 2 + GameScene.pixelSize
            }
            
            newNukeIcon.position = CGPoint(x: -5 * GameScene.pixelSize, y: y)
            newNukeIcon.colorBlendFactor = 1
            
            self.nukeIcon = newNukeIcon
            GameScene.scene.addChild(newNukeIcon)
        }
    }
    
    func getNukeIcon() -> SKTexture {
        var sprite: SKTexture!
       
        switch Nukes.currentNukes.type {
            case .line: sprite = SKTexture(imageNamed: "nuke_line_icon")
            case .laser: sprite = SKTexture(imageNamed: "nuke_laser_icon")
            case .missle: sprite = SKTexture(imageNamed: "nuke_missle_icon")
        }
        
        return sprite
    }
    
    func instantiateNumbers() {
        let firstFrame = spriteAtlas.textureNamed("frame0000")

        let sprite = firstFrame
        let size = CGSize(width: sprite.size().width/10 * GameScene.pixelSize, height: sprite.size().height/10 * GameScene.pixelSize)
        for i in 0...1 {
            let number = SKSpriteNode(texture: sprite, color: GameScene.spriteColor, size: size)
            number.colorBlendFactor = 1
            
            var y :CGFloat = 0
            switch GameScene.hudPosition {
                case .top: y = 24 * GameScene.pixelSize - size.height / 2 - GameScene.pixelSize
                case .bottom: y = -24 * GameScene.pixelSize + size.height / 2 + GameScene.pixelSize
            }
            
            number.position = CGPoint(
                x: 1 * GameScene.pixelSize + CGFloat(i) * (size.width + GameScene.pixelSize),
                y: y
            )
            numbers.append(number)
            
            GameScene.scene.addChild(number)
        }
    }
    
    func fireNuke() {
        if Nukes.currentNukes.count > 0 {
            Nukes.currentNukes.count -= 1
            renderNukesHud()
            
            switch Nukes.currentNukes.type {
                case .line: fireLineNuke()
                case .laser: fireLaserNuke()
                case .missle: fireMissleNuke()
            }
        }
    }
    
    func setNukes(nuke: (type: NukeType, count: Int)) {
        if Nukes.currentNukes.type == nuke.type {
            Nukes.currentNukes = (type: nuke.type, count: Nukes.currentNukes.count + nuke.count)
        } else {
            Nukes.currentNukes = nuke
        }
        renderNukesHud()
    }
    
    func renderNukesHud() {
        let nukeCountString = String(format: "%02d", Nukes.currentNukes.count)
        for (index, letter) in nukeCountString.enumerated() {
            let spriteName = "frame000\(letter)"
            numbers[index].texture = spriteAtlas.textureNamed(spriteName)
        }
        
        let sprite = getNukeIcon()
        nukeIcon?.texture = sprite
    }
    
    func fireLineNuke() {
        let lineNuke = instantiateLineNuke()
        let lineNukePosition = CGPoint(x: GameScene.player.position.x + GameScene.player.frame.width/2 + GameScene.pixelSize, y: GameScene.player.position.y)
        lineNuke.position = lineNukePosition
    }
    
    func fireLaserNuke() {
        let laserNuke = instantiateLaserNuke()
        let laserNukePosition = CGPoint(x: GameScene.player.position.x + GameScene.player.frame.width/2 + laserNuke.frame.width/2 + GameScene.pixelSize, y: GameScene.player.position.y)
        laserNuke.position = laserNukePosition
        laserNuke.spawn()
    }
    
    func fireMissleNuke() {
        let missleNuke = instantiateMissleNuke()
        let missleNukePosition = CGPoint(x: GameScene.player.position.x + GameScene.player.frame.width/2 + missleNuke.frame.width/2, y: GameScene.player.position.y)
        missleNuke.position = missleNukePosition
    }
    
    func instantiateLineNuke() -> LineNuke {
        let lineNuke = LineNuke()
        Nukes.lineNukes.append(lineNuke)
        GameScene.scene.addChild(lineNuke)
        return lineNuke
    }
    
    func instantiateLaserNuke() -> LaserNuke {
        let laserNuke = LaserNuke()
        Nukes.laserNukes.append(laserNuke)
        GameScene.scene.addChild(laserNuke)
        return laserNuke
    }
    
    func instantiateMissleNuke() -> MissleNuke {
        let missleNuke = MissleNuke()
        Nukes.missleNukes.append(missleNuke)
        GameScene.scene.addChild(missleNuke)
        return missleNuke
    }
    
    func update() {
        for lineNuke in Nukes.lineNukes {
            lineNuke.update()
        }
        for missleNuke in Nukes.missleNukes {
            missleNuke.update()
        }
        for laserNuke in Nukes.laserNukes {
            laserNuke.update()
        }
    }
}
