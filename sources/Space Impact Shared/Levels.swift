//
//  Level1.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 12/12/2020.
//

import SpriteKit

enum SpawnType {
    case enemy
    case powerUp
    case boss
    case finalBoss
}

struct SpawnObject {
    let spriteOrAtlas: String
    let time: TimeInterval
    let type: SpawnType
    var y: CGFloat? = nil
    var moves: [CGPoint]? = nil
    let speed: CGFloat
    var health: Int? = nil
    var shootInterval: TimeInterval? = nil
    var randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil
    var singleShootTimes: [TimeInterval]? = nil
    var score: Int? = nil
    var yOffset: Int? = nil
    var charge: (interval: TimeInterval, hideBefore: Bool)? = nil
    var randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil
    var minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)? = nil
    
    init(
        spriteOrAtlas: String,
        time: TimeInterval,
        type: SpawnType,
        y: CGFloat? = nil,
        moves: [CGPoint]? = nil,
        speed: CGFloat,
        health: Int? = nil,
        shootInterval: TimeInterval? = nil,
        randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil,
        singleShootTimes: [TimeInterval]? = nil,
        score: Int? = nil,
        yOffset: Int? = nil,
        charge: (interval: TimeInterval, hideBefore: Bool)? = nil,
        randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil,
        minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)? = nil
    ) {
        self.spriteOrAtlas = spriteOrAtlas
        self.time = time
        self.type = type
        self.y = y
        self.moves = moves
        self.speed = speed
        self.health = health
        self.shootInterval = shootInterval
        self.randomShootTimeIntervalRange = randomShootTimeIntervalRange
        self.singleShootTimes = singleShootTimes
        self.score = score
        self.yOffset = yOffset
        self.charge = charge
        self.randomMissleShootTimeIntervalRange = randomMissleShootTimeIntervalRange
        self.minionSpawner = minionSpawner
    }
}

class Levels {
    
    static let level1: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Comet", time: 2, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 3, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 4, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 6, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 7, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 9, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 20, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 11, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 20, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 12, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 13, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 14, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 35, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 14.1, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "PowerUp", time: 14.4, type: .powerUp, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35),
        SpawnObject(spriteOrAtlas: "Comet", time: 15, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 20, type: .enemy, y: 13, moves: [CGPoint(x: 18, y: 13), CGPoint(x: -5, y: -5), CGPoint(x: -48, y: -8)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 21, type: .enemy, y: 0, moves: [CGPoint(x: 30, y: -5), CGPoint(x: 18, y: 12), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 22, type: .enemy, y: 13, moves: [CGPoint(x: 18, y: 13), CGPoint(x: -5, y: -5), CGPoint(x: -48, y: -8)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 23, type: .enemy, y: 0, moves: [CGPoint(x: 30, y: -5), CGPoint(x: 18, y: 12), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24, type: .enemy, y: 13, moves: [CGPoint(x: 18, y: 13), CGPoint(x: -5, y: -5), CGPoint(x: -48, y: -8)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 25, type: .enemy, y: 0, moves: [CGPoint(x: 30, y: -5), CGPoint(x: 18, y: 12), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 26, type: .enemy, y: 13, moves: [CGPoint(x: 18, y: 13), CGPoint(x: -5, y: -5), CGPoint(x: -48, y: -8)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 27, type: .enemy, y: 0, moves: [CGPoint(x: 30, y: -5), CGPoint(x: 18, y: 12), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 35, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 38, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 38.5, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 41, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, singleShootTimes: [0.57, 2.49, 4.41, 6.33], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 42, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, singleShootTimes: [0.57, 2.49, 4.41, 6.33], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 43, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, singleShootTimes: [0.57, 2.49, 4.41, 6.33], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 45, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, singleShootTimes: [0.57, 2.49, 4.41, 6.33], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 46, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, singleShootTimes: [0.57, 2.49, 4.41, 6.33], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 51, type: .enemy, y: 12, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 52, type: .enemy, y: 12, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 54, type: .enemy, y: 12, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 55, type: .enemy, y: 12, moves: [CGPoint(x: 40, y: -5), CGPoint(x: 20, y: 12), CGPoint(x: 0, y: -5), CGPoint(x: -20, y: 12), CGPoint(x: -40, y: -5), CGPoint(x: -48, y: 12)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "PowerUp", time: 61, type: .powerUp, y: -8, moves: [CGPoint(x: -48, y: -8)], speed: 35),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 62, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 55, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 64, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 35, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 65, type: .enemy, y: -10, moves: [CGPoint(x: -48, y: -10)], speed: 55, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 65.5, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 55, health: 3, score: 10),
        SpawnObject(spriteOrAtlas: "Boss1", time: 67, type: .boss, speed: 20, health: 40, shootInterval: 4, score: 100),
    ]
    
    static let level2: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Rocket1", time: 0, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: -13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 0, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 1, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: -13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 1, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 2, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: -13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 2, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: 13)], speed: 35, health: 2, singleShootTimes: [0.1, 0.6], score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 3, type: .powerUp, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 35),
        
        SpawnObject(spriteOrAtlas: "Egg", time: 5, type: .enemy, y: 13, moves: [CGPoint(x: 32, y: 14), CGPoint(x: 16, y: 12), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 12), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 5, type: .enemy, y: -13, moves: [CGPoint(x: 32, y: -14), CGPoint(x: 16, y: -12), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -12), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 6, type: .enemy, y: 13, moves: [CGPoint(x: 32, y: 14), CGPoint(x: 16, y: 12), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 12), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 6, type: .enemy, y: -13, moves: [CGPoint(x: 32, y: -14), CGPoint(x: 16, y: -12), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -12), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 7, type: .enemy, y: 13, moves: [CGPoint(x: 32, y: 14), CGPoint(x: 16, y: 12), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 12), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 7, type: .enemy, y: -13, moves: [CGPoint(x: 32, y: -14), CGPoint(x: 16, y: -12), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -12), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -12)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 12, type: .enemy, y: 12, moves: [CGPoint(x: 32, y: 14), CGPoint(x: 16, y: 13), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 13), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 13)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 14, type: .enemy, y: 12, moves: [CGPoint(x: 32, y: 14), CGPoint(x: 16, y: 13), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 13), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 13)], speed: 25, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 16, type: .enemy, y: -13, moves: [CGPoint(x: 32, y: -14), CGPoint(x: 16, y: -13), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -13), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -13)], speed: 25, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 18, type: .enemy, y: -7, moves: [CGPoint(x: -48, y: -7)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 21, type: .enemy, y: 7, moves: [CGPoint(x: -48, y: 7)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 24, type: .enemy, y: -3, moves: [CGPoint(x: -48, y: -3)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 25, type: .enemy, y: 3, moves: [CGPoint(x: -48, y: 3)], speed: 40, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 25.5, type: .enemy, y: 14, moves: [CGPoint(x: -48, y: 14)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 25.5, type: .enemy, y: -14, moves: [CGPoint(x: -48, y: -14)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 29, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 30, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 31, type: .enemy, y: 14, moves: [CGPoint(x: -48, y: 14)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 31, type: .enemy, y: -14, moves: [CGPoint(x: -48, y: -14)], speed: 40, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket3", time: 36, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 37, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 38, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 39, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 40, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket3", time: 42, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 45, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 47, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 49, type: .enemy, y: 4, moves: [CGPoint(x: -48, y: 4)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 51, type: .enemy, y: -4, moves: [CGPoint(x: -48, y: -4)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 53, type: .enemy, y: 12, moves: [CGPoint(x: -48, y: 12)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        
        SpawnObject(spriteOrAtlas: "Boss2", time: 57, type: .boss, speed: 20, health: 30, shootInterval: 3, score: 100),
    ]
    
    static let level3: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Sperm1", time: 3, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 5, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 7, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 8, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 10, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 12, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 13, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 15, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 17, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: -15)], speed: 25, health: 1, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        
        SpawnObject(spriteOrAtlas: "Egg", time: 18, type: .enemy, y: -12, moves: [CGPoint(x: 40, y: -9), CGPoint(x: -48, y: -10)], speed: 55, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 19, type: .enemy, y: -12, moves: [CGPoint(x: 40, y: -9), CGPoint(x: -48, y: -10)], speed: 55, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 20, type: .enemy, y: -12, moves: [CGPoint(x: 40, y: -9), CGPoint(x: -48, y: -10)], speed: 55, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 21, type: .powerUp, y: -9, moves: [CGPoint(x: -48, y: -9)], speed: 25),
        
        SpawnObject(spriteOrAtlas: "Comet", time: 25, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 26, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 26, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 27, type: .enemy, y: 10, moves: [CGPoint(x: -48, y: 10)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 27, type: .enemy, y: -10, moves: [CGPoint(x: -48, y: -10)], speed: 40, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "Comet", time: 30, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 31, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 31, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 32, type: .enemy, y: 10, moves: [CGPoint(x: -48, y: 10)], speed: 40, health: 1, score: 5),
        SpawnObject(spriteOrAtlas: "Comet", time: 32, type: .enemy, y: -10, moves: [CGPoint(x: -48, y: -10)], speed: 40, health: 1, score: 5),
        
        SpawnObject(spriteOrAtlas: "Snake1", time: 34, type: .enemy, y: 12, moves: [CGPoint(x: 16, y: 3), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 3), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 3)], speed: 40, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 34.27, type: .enemy, y: 12, moves: [CGPoint(x: 16, y: 3), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 3), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 3)], speed: 40, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Snake3", time: 34.52, type: .enemy, y: 12, moves: [CGPoint(x: 16, y: 3), CGPoint(x: 0, y: 14), CGPoint(x: -16, y: 3), CGPoint(x: -32, y: 14), CGPoint(x: -48, y: 3)], speed: 40, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Snake1", time: 35, type: .enemy, y: -12, moves: [CGPoint(x: 16, y: -3), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -3), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -3)], speed: 40, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 35.27, type: .enemy, y: -12, moves: [CGPoint(x: 16, y: -3), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -3), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -3)], speed: 40, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Snake3", time: 35.52, type: .enemy, y: -12, moves: [CGPoint(x: 16, y: -3), CGPoint(x: 0, y: -14), CGPoint(x: -16, y: -3), CGPoint(x: -32, y: -14), CGPoint(x: -48, y: -3)], speed: 40, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 40, type: .enemy, y: 0, moves: [CGPoint(x: 25, y: 0), CGPoint(x: 25, y: -16), CGPoint(x: 25, y: 16), CGPoint(x: 25, y: -16), CGPoint(x: 25, y: 16), CGPoint(x: 25, y: 0), CGPoint(x: -48, y: 0)], speed: 30, health: 15, randomShootTimeIntervalRange: (min: 0.1, max: 3), score: 5),
        
        SpawnObject(spriteOrAtlas: "Boss3", time: 54, type: .boss, speed: 20, health: 55, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, yOffset: 13, charge: (interval: 8, hideBefore: false)),
    ]
    
    static let level4: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Beatle1", time: 2, type: .enemy, y: 15, moves: [CGPoint(x: 35, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 2.5, type: .enemy, y: 15, moves: [CGPoint(x: 35, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 3, type: .enemy, y: 15, moves: [CGPoint(x: 35, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 3.5, type: .enemy, y: 15, moves: [CGPoint(x: 35, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 4, type: .enemy, y: 15, moves: [CGPoint(x: 35, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 5, type: .enemy, y: 15, moves: [CGPoint(x: 30, y: 15), CGPoint(x: -30, y: -6), CGPoint(x: -48, y: -6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 5.5, type: .enemy, y: 15, moves: [CGPoint(x: 30, y: 15), CGPoint(x: -30, y: -6), CGPoint(x: -48, y: -6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 6, type: .enemy, y: 15, moves: [CGPoint(x: 30, y: 15), CGPoint(x: -30, y: -6), CGPoint(x: -48, y: -6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 6.5, type: .enemy, y: 15, moves: [CGPoint(x: 30, y: 15), CGPoint(x: -30, y: -6), CGPoint(x: -48, y: -6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 7, type: .enemy, y: 15, moves: [CGPoint(x: 30, y: 15), CGPoint(x: -30, y: -6), CGPoint(x: -48, y: -6)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 8, type: .enemy, y: -6, moves: [CGPoint(x: 30, y: -6), CGPoint(x: -30, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 8.5, type: .enemy, y: -6, moves: [CGPoint(x: 30, y: -6), CGPoint(x: -30, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 9, type: .enemy, y: -6, moves: [CGPoint(x: 30, y: -6), CGPoint(x: -30, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 9.5, type: .enemy, y: -6, moves: [CGPoint(x: 30, y: -6), CGPoint(x: -30, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 10, type: .enemy, y: -6, moves: [CGPoint(x: 30, y: -6), CGPoint(x: -30, y: 12), CGPoint(x: -48, y: 12)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket3", time: 12, type: .enemy, y: -2, moves: [CGPoint(x: -48, y: -2)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 14, type: .enemy, y: 12, moves: [CGPoint(x: -48, y: 12)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 14.5, type: .enemy, y: 12, moves: [CGPoint(x: -48, y: 12)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 15, type: .enemy, y: 12, moves: [CGPoint(x: -48, y: 12)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 16, type: .enemy, y: -6, moves: [CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 16.5, type: .enemy, y: -6, moves: [CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket3", time: 19, type: .enemy, y: 1, moves: [CGPoint(x: -48, y: 1)], speed: 50, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 19.5, type: .enemy, y: 1, moves: [CGPoint(x: -48, y: 1)], speed: 50, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 20, type: .enemy, y: 1, moves: [CGPoint(x: -48, y: 1)], speed: 50, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 25, type: .powerUp, y: 0, moves: [CGPoint(x: 40, y: -6), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -6), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -6), CGPoint(x: -35, y: 13), CGPoint(x: -50, y: -6)], speed: 35),
        
        SpawnObject(spriteOrAtlas: "Mine1", time: 31, type: .enemy, y: 7, moves: [CGPoint(x: -48, y: 7)], speed: 25, health: 10, score: 5),
        SpawnObject(spriteOrAtlas: "Mine1", time: 33, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 25, health: 10, score: 5),
        SpawnObject(spriteOrAtlas: "Mine1", time: 35, type: .enemy, y: -7, moves: [CGPoint(x: -48, y: -7)], speed: 25, health: 10, score: 5),
        SpawnObject(spriteOrAtlas: "Mine1", time: 37, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -7)], speed: 25, health: 10, score: 5),
        SpawnObject(spriteOrAtlas: "Mine1", time: 39, type: .enemy, y: 13, moves: [CGPoint(x: -48, y: 13)], speed: 25, health: 10, score: 5),
        SpawnObject(spriteOrAtlas: "Mine1", time: 41, type: .enemy, y: -12, moves: [CGPoint(x: -48, y: -12)], speed: 25, health: 10, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 47, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 47.5, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 48, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 48.5, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 49, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 49.5, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 50, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 50.5, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 51, type: .enemy, y: 0, moves: [CGPoint(x: 40, y: -11), CGPoint(x: 25, y: 13), CGPoint(x: 10, y: -11), CGPoint(x: -5, y: 13), CGPoint(x: -20, y: -11), CGPoint(x: -35, y: 13), CGPoint(x: -48, y: -11)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 53, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 53.5, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 55, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 55.5, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 57, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 57.5, type: .enemy, y: 15, moves: [CGPoint(x: 5, y: -11), CGPoint(x: -5, y: -11), CGPoint(x: -5, y: 15), CGPoint(x: -48, y: -11)], speed: 45, health: 1, score: 10),
        
        SpawnObject(spriteOrAtlas: "Boss4", time: 60, type: .boss, speed: 20, health: 65, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, yOffset: 6, randomMissleShootTimeIntervalRange: (min: 1, max: 5)),
    ]
    
    static let level5: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 2, type: .enemy, y: -15, moves: [CGPoint(x: 10, y: -15), CGPoint(x: -10, y: 7), CGPoint(x: -48, y: 7)], speed: 25, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 3.5, type: .enemy, y: -15, moves: [CGPoint(x: 10, y: -15), CGPoint(x: -10, y: 7), CGPoint(x: -48, y: 7)], speed: 25, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 5, type: .enemy, y: -15, moves: [CGPoint(x: 10, y: -15), CGPoint(x: -10, y: 7), CGPoint(x: -48, y: 7)], speed: 25, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 5, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -11)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 5.5, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -11)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 6, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -11)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 6.5, type: .enemy, y: -13, moves: [CGPoint(x: 10, y: -15), CGPoint(x: -10, y: 7), CGPoint(x: -48, y: 7)], speed: 25, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 6.5, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -11)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 7, type: .enemy, y: -11, moves: [CGPoint(x: -48, y: -11)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "SmallEgg", time: 8, type: .enemy, y: -13, moves: [CGPoint(x: 10, y: -15), CGPoint(x: -10, y: 7), CGPoint(x: -48, y: 7)], speed: 25, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 9, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 10, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 15, type: .powerUp, y: 0, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 30),
        
        SpawnObject(spriteOrAtlas: "Sperm1", time: 19, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 20, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 21, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 21.6, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 22, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 23, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 23.6, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 24, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Sperm1", time: 25, type: .enemy, y: -5, moves: [CGPoint(x: 40, y: -15), CGPoint(x: 25, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: -5, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -35, y: 6), CGPoint(x: -50, y: -15)], speed: 25, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 27, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 27.8, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 27.8, type: .enemy, y: -6, moves: [CGPoint(x: -48, y: -6)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 29, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 29.8, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 29.8, type: .enemy, y: -6, moves: [CGPoint(x: -48, y: -6)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 31, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 31, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 33, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 33, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 35, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 35, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 37, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 37, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 39, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 39, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 41, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -13), CGPoint(x: -48, y: -13)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 41, type: .enemy, y: -13, moves: [CGPoint(x: 20, y: -13), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 25, health: 5, randomShootTimeIntervalRange: (min: 3, max: 3.5), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 41, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 42, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 43, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 44, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 45, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 46, type: .enemy, y: 6, moves: [CGPoint(x: 40, y: 6), CGPoint(x: 30, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -30, y: -15), CGPoint(x: -48, y: -15)], speed: 25, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 47, type: .enemy, y: -15, moves: [CGPoint(x: 30, y: -15), CGPoint(x: -30, y: 6), CGPoint(x: -48, y: 6)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 48, type: .enemy, y: -15, moves: [CGPoint(x: 30, y: -15), CGPoint(x: -30, y: 6), CGPoint(x: -48, y: 6)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 49, type: .enemy, y: -15, moves: [CGPoint(x: 30, y: -15), CGPoint(x: -30, y: 6), CGPoint(x: -48, y: 6)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 50, type: .enemy, y: -15, moves: [CGPoint(x: 30, y: -15), CGPoint(x: -30, y: 6), CGPoint(x: -48, y: 6)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 51, type: .enemy, y: -15, moves: [CGPoint(x: 30, y: -15), CGPoint(x: -30, y: 6), CGPoint(x: -48, y: 6)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 53, type: .enemy, y: 6, moves: [CGPoint(x: 10, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: 10, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: 10, y: 6), CGPoint(x: 10, y: -15), CGPoint(x: 10, y: 6), CGPoint(x: -48, y: 0)], speed: 25, health: 25, randomShootTimeIntervalRange: (min: 0.5, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Boss5", time: 70, type: .boss, speed: 20, health: 80, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, yOffset: 6, charge: (interval: 16, hideBefore: false), minionSpawner: (spriteOrAtlas: "Beatle1", health: 1, minionSpeed: 45, zigZag: false, score: 100, min: 2, max: 5)),
    ]
    
    static let level6: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Rocket1", time: 2, type: .enemy, y: -3, moves: [CGPoint(x: -48, y: -3)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 2.5, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 3, type: .enemy, y: 3, moves: [CGPoint(x: -48, y: 3)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 3.5, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 5, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 50, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 5.5, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 50, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 6, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 50, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 6.5, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 50, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 8, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 8.5, type: .enemy, y: -7, moves: [CGPoint(x: -48, y: -7)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 9, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 9.5, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 11, type: .powerUp, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15, type: .enemy, y: -15, moves: [CGPoint(x: 40, y: -12), CGPoint(x: 30, y: -15), CGPoint(x: 20, y: -13), CGPoint(x: 10, y: -15), CGPoint(x: 0, y: -13), CGPoint(x: -10, y: -15), CGPoint(x: -20, y: -13), CGPoint(x: -30, y: -15), CGPoint(x: -40, y: -13), CGPoint(x: -50, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15.4, type: .enemy, y: -15, moves: [CGPoint(x: 40, y: -12), CGPoint(x: 30, y: -15), CGPoint(x: 20, y: -13), CGPoint(x: 10, y: -15), CGPoint(x: 0, y: -13), CGPoint(x: -10, y: -15), CGPoint(x: -20, y: -13), CGPoint(x: -30, y: -15), CGPoint(x: -40, y: -13), CGPoint(x: -50, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15.8, type: .enemy, y: -15, moves: [CGPoint(x: 40, y: -12), CGPoint(x: 30, y: -15), CGPoint(x: 20, y: -13), CGPoint(x: 10, y: -15), CGPoint(x: 0, y: -13), CGPoint(x: -10, y: -15), CGPoint(x: -20, y: -13), CGPoint(x: -30, y: -15), CGPoint(x: -40, y: -13), CGPoint(x: -50, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 16.2, type: .enemy, y: -15, moves: [CGPoint(x: 40, y: -12), CGPoint(x: 30, y: -15), CGPoint(x: 20, y: -13), CGPoint(x: 10, y: -15), CGPoint(x: 0, y: -13), CGPoint(x: -10, y: -15), CGPoint(x: -20, y: -13), CGPoint(x: -30, y: -15), CGPoint(x: -40, y: -13), CGPoint(x: -50, y: -15)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 19, type: .powerUp, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 45),
        SpawnObject(spriteOrAtlas: "Egg", time: 19, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 19, type: .enemy, y: -15, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -15), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -15), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        
        SpawnObject(spriteOrAtlas: "Egg", time: 19.5, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 19.5, type: .enemy, y: -15, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -15), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -15), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 3), score: 5),
        
        SpawnObject(spriteOrAtlas: "Egg", time: 20, type: .enemy, y: 6, moves: [CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Egg", time: 20, type: .enemy, y: -15, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -15), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -15), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24.5, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24.5, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket1", time: 25, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 25, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 3, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 25.5, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 35, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Snake1", time: 27, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 27.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 28, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 28.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 29, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Snake2", time: 29.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Jelly1", time: 31, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Jelly1", time: 31.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Jelly1", time: 32, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Jelly1", time: 32.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35.3, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35.3, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35.6, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 35.6, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "PowerUp", time: 40, type: .powerUp, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 50),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 44, type: .enemy, y: 6, moves: [CGPoint(x: 32, y: 6), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: 6), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: 0), CGPoint(x: -48, y: 6)], speed: 45, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 47, type: .enemy, y: 6, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 3, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 48, type: .enemy, y: 6, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 3, score: 5),
        
        SpawnObject(spriteOrAtlas: "Jelly1", time: 52, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Jelly1", time: 52.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Jelly1", time: 53, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: 6), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: 6)], speed: 40, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54.3, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54.3, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54.6, type: .enemy, y: 6, moves: [CGPoint(x: 20, y: 6), CGPoint(x: -20, y: -15), CGPoint(x: -48, y: -15)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 54.6, type: .enemy, y: -15, moves: [CGPoint(x: 20, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: 6)], speed: 45, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 58, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 0), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 58.5, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 0), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 59, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 0), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 59.5, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 0), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket2", time: 60, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 60.5, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 61, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 61.5, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 62, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 62.5, type: .enemy, y: 0, moves: [CGPoint(x: 20, y: -15), CGPoint(x: 0, y: 6), CGPoint(x: 0, y: -15), CGPoint(x: -20, y: 6), CGPoint(x: -48, y: -15)], speed: 45, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Boss6", time: 65, type: .boss, speed: 20, health: 60, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, yOffset: 15, charge: (interval: 8, hideBefore: true), minionSpawner: (spriteOrAtlas: "Sperm1", health: 1, minionSpeed: 40, zigZag: false, score: 100, min: 2, max: 5)),
    ]
    
    static let level7: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Drone1", time: 2, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 2, type: .enemy, y: -11, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: -11), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: -11), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: -11)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 2.5, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 2.5, type: .enemy, y: -11, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: -11), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: -11), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: -11)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 4, type: .enemy, y: 7, moves: [CGPoint(x: 32, y: 11), CGPoint(x: 16, y: 7), CGPoint(x: 0, y: 11), CGPoint(x: -16, y: 7), CGPoint(x: -32, y: 11), CGPoint(x: -48, y: 7)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 4, type: .enemy, y: -11, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: -11), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: -11), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: -11)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 4.5, type: .enemy, y: 7, moves: [CGPoint(x: 32, y: 11), CGPoint(x: 16, y: 7), CGPoint(x: 0, y: 11), CGPoint(x: -16, y: 7), CGPoint(x: -32, y: 11), CGPoint(x: -48, y: 7)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 4.5, type: .enemy, y: -11, moves: [CGPoint(x: 32, y: -15), CGPoint(x: 16, y: -11), CGPoint(x: 0, y: -15), CGPoint(x: -16, y: -11), CGPoint(x: -32, y: -15), CGPoint(x: -48, y: -11)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 7, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 7, type: .enemy, y: -7, moves: [CGPoint(x: 10, y: -7), CGPoint(x: -30, y: 15), CGPoint(x: -48, y: 15)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        
        SpawnObject(spriteOrAtlas: "Drone1", time: 7.5, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 50, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Drone1", time: 7.5, type: .enemy, y: -7, moves: [CGPoint(x: 10, y: -7), CGPoint(x: -30, y: 15), CGPoint(x: -48, y: 15)], speed: 40, health: 1, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),

        SpawnObject(spriteOrAtlas: "Beatle1", time: 11, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 11.3, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 11.6, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 11.9, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 55, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 13, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 13.3, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 13.6, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 55, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 13.9, type: .enemy, y: -13, moves: [CGPoint(x: -48, y: -13)], speed: 55, health: 2, score: 5),

        SpawnObject(spriteOrAtlas: "Beatle1", time: 15, type: .enemy, y: 15, moves: [CGPoint(x: 10, y: 15), CGPoint(x: -10, y: -14), CGPoint(x: -48, y: -14)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15.3, type: .enemy, y: 15, moves: [CGPoint(x: 10, y: 15), CGPoint(x: -10, y: -14), CGPoint(x: -48, y: -14)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15.6, type: .enemy, y: 15, moves: [CGPoint(x: 10, y: 15), CGPoint(x: -10, y: -14), CGPoint(x: -48, y: -14)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 15.9, type: .enemy, y: 15, moves: [CGPoint(x: 10, y: 15), CGPoint(x: -10, y: -14), CGPoint(x: -48, y: -14)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 16.2, type: .enemy, y: 15, moves: [CGPoint(x: 10, y: 15), CGPoint(x: -10, y: -14), CGPoint(x: -48, y: -14)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),

        SpawnObject(spriteOrAtlas: "Beatle1", time: 18, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 18.3, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 18.6, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 18.9, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 55, health: 2, randomShootTimeIntervalRange: (min: 1, max: 2), score: 5),

        SpawnObject(spriteOrAtlas: "Rocket1", time: 20, type: .enemy, y: 15, moves: [CGPoint(x: 0, y: -12), CGPoint(x: -48, y: -12)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 20.5, type: .enemy, y: 15, moves: [CGPoint(x: 0, y: -12), CGPoint(x: -48, y: -12)], speed: 35, health: 2,score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 21, type: .enemy, y: 15, moves: [CGPoint(x: 0, y: -12), CGPoint(x: -48, y: -12)], speed: 35, health: 2, score: 5),

        SpawnObject(spriteOrAtlas: "Rocket1", time: 22, type: .enemy, y: -11, moves: [CGPoint(x: 10, y: -11), CGPoint(x: -10, y: 14), CGPoint(x: -48, y: 14)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 22.5, type: .enemy, y: -11, moves: [CGPoint(x: 10, y: -11), CGPoint(x: -10, y: 14), CGPoint(x: -48, y: 14)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 23, type: .enemy, y: -11, moves: [CGPoint(x: 10, y: -11), CGPoint(x: -10, y: 14), CGPoint(x: -48, y: 14)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 23.5, type: .enemy, y: -11, moves: [CGPoint(x: 10, y: -11), CGPoint(x: -10, y: 14), CGPoint(x: -48, y: 14)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 24, type: .enemy, y: -11, moves: [CGPoint(x: 10, y: -11), CGPoint(x: -10, y: 14), CGPoint(x: -48, y: 14)], speed: 35, health: 2, score: 5),

        SpawnObject(spriteOrAtlas: "Rocket1", time: 26, type: .enemy, y: 15, moves: [CGPoint(x: 0, y: -12), CGPoint(x: -48, y: -12)], speed: 35, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket1", time: 26.5, type: .enemy, y: 15, moves: [CGPoint(x: 0, y: -12), CGPoint(x: -48, y: -12)], speed: 35, health: 2, score: 5),

        SpawnObject(spriteOrAtlas: "Rocket3", time: 29, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 29.3, type: .enemy, y: 10, moves: [CGPoint(x: -48, y: 10)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 29.3, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 29.6, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: 15)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 29.6, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 4, score: 5),
        
        SpawnObject(spriteOrAtlas: "Rocket3", time: 34, type: .enemy, y: 5, moves: [CGPoint(x: -48, y: 5)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 34.3, type: .enemy, y: 10, moves: [CGPoint(x: -48, y: 10)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 34.3, type: .enemy, y: 0, moves: [CGPoint(x: -48, y: 0)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 34.6, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: 15)], speed: 40, health: 4, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket3", time: 34.6, type: .enemy, y: -5, moves: [CGPoint(x: -48, y: -5)], speed: 40, health: 4, score: 5),

        SpawnObject(spriteOrAtlas: "Beatle1", time: 38, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 38, type: .enemy, y: 5, moves: [CGPoint(x: 32, y: 9), CGPoint(x: 16, y: 5), CGPoint(x: 0, y: 9), CGPoint(x: -16, y: 5), CGPoint(x: -32, y: 9), CGPoint(x: -48, y: 5)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 38.5, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 38.5, type: .enemy, y: 5, moves: [CGPoint(x: 32, y: 9), CGPoint(x: 16, y: 5), CGPoint(x: 0, y: 9), CGPoint(x: -16, y: 5), CGPoint(x: -32, y: 9), CGPoint(x: -48, y: 5)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 39, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 39, type: .enemy, y: 5, moves: [CGPoint(x: 32, y: 9), CGPoint(x: 16, y: 5), CGPoint(x: 0, y: 9), CGPoint(x: -16, y: 5), CGPoint(x: -32, y: 9), CGPoint(x: -48, y: 5)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 39.5, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 39.5, type: .enemy, y: 5, moves: [CGPoint(x: 32, y: 9), CGPoint(x: 16, y: 5), CGPoint(x: 0, y: 9), CGPoint(x: -16, y: 5), CGPoint(x: -32, y: 9), CGPoint(x: -48, y: 5)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 40, type: .enemy, y: 11, moves: [CGPoint(x: 32, y: 15), CGPoint(x: 16, y: 11), CGPoint(x: 0, y: 15), CGPoint(x: -16, y: 11), CGPoint(x: -32, y: 15), CGPoint(x: -48, y: 11)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 40, type: .enemy, y: 5, moves: [CGPoint(x: 32, y: 9), CGPoint(x: 16, y: 5), CGPoint(x: 0, y: 9), CGPoint(x: -16, y: 5), CGPoint(x: -32, y: 9), CGPoint(x: -48, y: 5)], speed: 40, health: 2, score: 5),
        
        SpawnObject(spriteOrAtlas: "Beatle1", time: 42, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -4), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: -4), CGPoint(x: -16, y: 0), CGPoint(x: -32, y: -4), CGPoint(x: -48, y: 0)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 42, type: .enemy, y: -6, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -6), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -6), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 42.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -4), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: -4), CGPoint(x: -16, y: 0), CGPoint(x: -32, y: -4), CGPoint(x: -48, y: 0)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 42.5, type: .enemy, y: -6, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -6), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -6), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 43, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -4), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: -4), CGPoint(x: -16, y: 0), CGPoint(x: -32, y: -4), CGPoint(x: -48, y: 0)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 43, type: .enemy, y: -6, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -6), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -6), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 43.5, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -4), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: -4), CGPoint(x: -16, y: 0), CGPoint(x: -32, y: -4), CGPoint(x: -48, y: 0)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 43.5, type: .enemy, y: -6, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -6), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -6), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 44, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -4), CGPoint(x: 16, y: 0), CGPoint(x: 0, y: -4), CGPoint(x: -16, y: 0), CGPoint(x: -32, y: -4), CGPoint(x: -48, y: 0)], speed: 40, health: 2, score: 5),
        SpawnObject(spriteOrAtlas: "Beatle1", time: 44, type: .enemy, y: -6, moves: [CGPoint(x: 32, y: -10), CGPoint(x: 16, y: -6), CGPoint(x: 0, y: -10), CGPoint(x: -16, y: -6), CGPoint(x: -32, y: -10), CGPoint(x: -48, y: -6)], speed: 40, health: 2, score: 5),
       
        SpawnObject(spriteOrAtlas: "Boss7", time: 49.3, type: .boss, speed: 20, health: 60, randomShootTimeIntervalRange: (min: 0.5, max: 2), score: 5, yOffset: 2, charge: (interval: 8, hideBefore: true), minionSpawner: (spriteOrAtlas: "Jelly1", health: 1, minionSpeed: 35, zigZag: true, score: 100, min: 2, max: 5)),

    ]
    
    static let level8: [SpawnObject] = [
        SpawnObject(spriteOrAtlas: "Rocket2", time: 2, type: .enemy, y: 15, moves: [CGPoint(x: -48, y: 15)], speed: 35, health: 8, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 2, type: .enemy, y: 7, moves: [CGPoint(x: -48, y: 7)], speed: 35, health: 8, score: 5),
        SpawnObject(spriteOrAtlas: "Rocket2", time: 2, type: .enemy, y: -6, moves: [CGPoint(x: -48, y: -6)], speed: 35, health: 8, score: 5),

        SpawnObject(spriteOrAtlas: "Beatle2", time: 5, type: .enemy, y: 15, moves: [CGPoint(x: 32, y: 15), CGPoint(x: -10, y: -6), CGPoint(x: -48, y: -6)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 6, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -6), CGPoint(x: 16, y: 15), CGPoint(x: 0, y: -6), CGPoint(x: -16, y: 15), CGPoint(x: -32, y: -6), CGPoint(x: -48, y: 15)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),

        SpawnObject(spriteOrAtlas: "Beatle2", time: 7, type: .enemy, y: 15, moves: [CGPoint(x: 32, y: 15), CGPoint(x: -10, y: -6), CGPoint(x: -48, y: -6)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 8, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -6), CGPoint(x: 16, y: 15), CGPoint(x: 0, y: -6), CGPoint(x: -16, y: 15), CGPoint(x: -32, y: -6), CGPoint(x: -48, y: 15)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),

        SpawnObject(spriteOrAtlas: "Beatle2", time: 9, type: .enemy, y: 15, moves: [CGPoint(x: 32, y: 15), CGPoint(x: -10, y: -6), CGPoint(x: -48, y: -6)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 10, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -6), CGPoint(x: 16, y: 15), CGPoint(x: 0, y: -6), CGPoint(x: -16, y: 15), CGPoint(x: -32, y: -6), CGPoint(x: -48, y: 15)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),

        SpawnObject(spriteOrAtlas: "Beatle2", time: 11, type: .enemy, y: 15, moves: [CGPoint(x: 32, y: 15), CGPoint(x: -10, y: -6), CGPoint(x: -48, y: -6)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        SpawnObject(spriteOrAtlas: "Beatle2", time: 12, type: .enemy, y: 0, moves: [CGPoint(x: 32, y: -6), CGPoint(x: 16, y: 15), CGPoint(x: 0, y: -6), CGPoint(x: -16, y: 15), CGPoint(x: -32, y: -6), CGPoint(x: -48, y: 15)], speed: 25, health: 4, randomShootTimeIntervalRange: (min: 1, max: 4), score: 5),
        
        SpawnObject(spriteOrAtlas: "Boss8", time: 14, type: .finalBoss, speed: 20, health: 70, score: 100, randomMissleShootTimeIntervalRange: (min: 1, max: 5))
    ]
    
    
}
