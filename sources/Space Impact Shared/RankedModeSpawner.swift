//
//  RankedModeSpawner.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 10/05/2021.
//

import Foundation
import UIKit

class RankedModeSpawner {
    
    private var seed : Decimal = Decimal(string: "12467548791243467501")!
    private var salt1 : Decimal = Decimal(string: "126549617")!
    private var salt2 : Decimal = Decimal(string: "265984797")!
    
    private var currentRandom = 1
    
    private var nextSpawnDate : Date = Date()
    private var lastSpawnTime : TimeInterval = 0
    
    var spawns : [SpawnObject] = []
    
    static var pausedBecauseOfBoss = false
    
    func getSpawns(inLevelTime: TimeInterval) -> [SpawnObject] {
        
        if Date() > nextSpawnDate && !RankedModeSpawner.pausedBecauseOfBoss {
            let random = getRandom()
            
            let nextSpawnTime = getNextSpawnTime(numbers: random)
            
            self.nextSpawnDate = Date().addingTimeInterval(TimeInterval(nextSpawnTime))
            
            let spawnType = getSpawnType(numbers: random)
            let spriteAtlass = getSpriteAtlass(numbers: random, spawnType: spawnType)
            let y = getY(numbers: random)
            let moves = getMoves(numbers: random, y: y)
            let speed = getSpeed(numbers: random)
            let health = getHealth(numbers: random)
            let count = getCount(numbers: random)
            let shootInterval = getShootInterval(numbers: random)
            
            if spawns.last?.type == .boss {
                lastSpawnTime = inLevelTime
            } else {
                lastSpawnTime = spawns.last?.time ?? 0
            }
            
            if currentRandom % 30 == 0 {
                let boss = getBoss(numbers: random, time: lastSpawnTime + Double(nextSpawnTime))
                spawns.append(boss)
                RankedModeSpawner.pausedBecauseOfBoss = true
            }
            else if spawnType == .powerUp {
                spawns.append(SpawnObject(spriteOrAtlas: spriteAtlass, time: lastSpawnTime + Double(nextSpawnTime), type: spawnType, y: y, moves: moves, speed: speed, health: health, score: 0))
            } else {
                for i in 0...count {
                    let time : TimeInterval = lastSpawnTime + Double(nextSpawnTime) + TimeInterval(Double(25 / speed) * Double(i))
                    spawns.append(SpawnObject(spriteOrAtlas: spriteAtlass, time: time, type: spawnType, y: y, moves: moves, speed: speed,health: health, shootInterval: shootInterval, score: 5))
                }
            }
        }
        
        return spawns
    }
    
    func getRandom() -> String {
        let salt1String = "\(salt1 + Decimal(string: String(currentRandom))! * salt1)".prefix(10)
        let salt2String = "\(salt2 + Decimal(string: String(currentRandom))! * salt2)".prefix(10)
        
        let finalSalt : String = String(salt1String + salt2String)
        
        let randomized : Decimal = seed + Decimal(string: finalSalt)!
        let substring = "\(randomized)".prefix(20)
        
        seed = Decimal(string : String(substring))!
        salt1 = Decimal(string: String(salt1String))!
        salt2 = Decimal(string: String(salt2String))!
        currentRandom += 1
        
        return String(substring)
    }
    
    func getSpriteAtlass(numbers: String, spawnType: SpawnType) -> String {
        let spriteAtlasses = ["Beatle1", "Beatle2", "Comet", "Drone1", "Egg", "Jelly1", "Mine1", "Rocket1", "Rocket2", "Rocket3", "SmallEgg", "Sperm1"]
        
        if spawnType == .powerUp {
            return "PowerUp"
        }
        
        let start = numbers.index(numbers.startIndex, offsetBy: 0)
        let end = numbers.index(numbers.startIndex, offsetBy: 2)
        let range = start..<end
        
        let number = Int(numbers[range])!
        return spriteAtlasses[number % spriteAtlasses.count]
    }
    
    func getNextSpawnTime(numbers: String) -> Int {
        let start = numbers.index(numbers.startIndex, offsetBy: 2)
        let end = numbers.index(numbers.startIndex, offsetBy: 3)
        let range = start..<end
        
        let number = Int(numbers[range])!
        return max(1, number/2)
    }
    
    func getSpawnType(numbers: String) -> SpawnType {
        let start = numbers.index(numbers.startIndex, offsetBy: 3)
        let end = numbers.index(numbers.startIndex, offsetBy: 5)
        let range = start..<end
        
        let number = Int(numbers[range])!
        if number > 90 {
            return .powerUp
        } else {
            return.enemy
        }
    }
    
    func getY(numbers: String) -> CGFloat {
        let start = numbers.index(numbers.startIndex, offsetBy: 6)
        let end = numbers.index(numbers.startIndex, offsetBy: 7)
        let range = start..<end
        
        let number = CGFloat(Int(numbers[range])! + 1)
        
        return -23 + number/10 * 36
    }
    
    func getMoves(numbers: String, y: CGFloat) -> [CGPoint] {
        var start = numbers.index(numbers.startIndex, offsetBy: 8)
        var end = numbers.index(numbers.startIndex, offsetBy: 9)
        var range = start..<end
        
        let maxY : CGFloat = 13
        let minY : CGFloat = -21
        let halfY : CGFloat = (abs(maxY) + abs(minY)) / 2
        let middleY : CGFloat = minY + halfY
        
        let yModifier = CGFloat(Int(numbers[range])! + 1) / 10
        
        var halfRangeY : CGFloat = y + yModifier * halfY
        var fullRangeY : CGFloat = 0
        if halfRangeY > maxY || halfRangeY < minY {
            halfRangeY = y - yModifier * halfY
        } else {
            halfRangeY = y + yModifier * halfY
        }
        
        if y > middleY {
            fullRangeY = minY * yModifier
        } else {
            fullRangeY = maxY * yModifier
        }
        
        let moves = [
            [CGPoint(x: -48, y: y)],
            [CGPoint(x: 0, y: halfRangeY), CGPoint(x: -48, y: y)],
            [CGPoint(x: 32, y: halfRangeY), CGPoint(x: 16, y: y), CGPoint(x: 0, y: halfRangeY), CGPoint(x: -16, y: y), CGPoint(x: -32, y: halfRangeY), CGPoint(x: -48, y: y)],
            [CGPoint(x: 0, y: fullRangeY), CGPoint(x: 0, y: y), CGPoint(x: -48, y: y)],
            [CGPoint(x: 0, y: fullRangeY), CGPoint(x: 0, y: y), CGPoint(x: -48, y: fullRangeY)],
            [CGPoint(x: 0, y: y), CGPoint(x: 0, y: halfRangeY), CGPoint(x: -48, y: halfRangeY)],
            [CGPoint(x: 16, y: y), CGPoint(x: 16, y: halfRangeY), CGPoint(x: -16, y: halfRangeY), CGPoint(x: -16, y: y), CGPoint(x: -48, y: y)],
            [CGPoint(x: -16, y: y), CGPoint(x: -16, y: fullRangeY), CGPoint(x: 40, y: halfRangeY), CGPoint(x: -48, y: halfRangeY)],
            [CGPoint(x: -16, y: y), CGPoint(x: -16, y: fullRangeY), CGPoint(x: 40, y: halfRangeY), CGPoint(x: -16, y: y), CGPoint(x: -48, y: y)],
            [CGPoint(x: 16, y: y), CGPoint(x: 40, y: fullRangeY), CGPoint(x: 16, y: fullRangeY), CGPoint(x: -16, y: y), CGPoint(x: -16, y: fullRangeY), CGPoint(x: -48, y: fullRangeY)],
        ]
        
        start = numbers.index(numbers.startIndex, offsetBy: 9)
        end = numbers.index(numbers.startIndex, offsetBy: 11)
        range = start..<end
        
        let number = Int(numbers[range])!
        return moves[number % moves.count]
    }
    
    func getSpeed(numbers: String) -> CGFloat {
        let start = numbers.index(numbers.startIndex, offsetBy: 12)
        let end = numbers.index(numbers.startIndex, offsetBy: 13)
        let range = start..<end
        
        let number = Int(numbers[range])!
        let speed = number + (currentRandom / 10) * number
        
        if speed < 20 {
            return 20
        }
        
        if speed > 50 {
            return 50
        }
        
        return CGFloat(speed)
    }
    
    func getHealth(numbers: String) -> Int {
        let start = numbers.index(numbers.startIndex, offsetBy: 14)
        let end = numbers.index(numbers.startIndex, offsetBy: 15)
        let range = start..<end
        
        let number = Int(numbers[range])!
        switch number {
        case 0,1,2: return 1
        case 3,4,5,6: return 2
        case 7,8: return 3
        case 9: return 4
        default: return 1
        }
    }
    
    func getCount(numbers: String) -> Int {
        let start = numbers.index(numbers.startIndex, offsetBy: 16)
        let end = numbers.index(numbers.startIndex, offsetBy: 17)
        let range = start..<end
        
        let count = Int(numbers[range])!
        
        return count/2
    }
    
    func getShootInterval(numbers: String) -> TimeInterval? {
        let start = numbers.index(numbers.startIndex, offsetBy: 18)
        let end = numbers.index(numbers.startIndex, offsetBy: 19)
        let range = start..<end
        
        let number = Int(numbers[range])!
        
        if number < 6 {
            return max(1.5, Double(number))
        }
        
        return nil
    }
    
    func getBoss(numbers: String, time: TimeInterval) -> SpawnObject {
        let bosses = [
            SpawnObject(spriteOrAtlas: "Boss1", time: time, type: .boss, speed: 20, health: 40, shootInterval: 4, score: 100),
            SpawnObject(spriteOrAtlas: "Boss2", time: time, type: .boss, speed: 20, health: 30, shootInterval: 3, score: 100),
            SpawnObject(spriteOrAtlas: "Boss3", time: time, type: .boss, speed: 20, health: 55, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, charge: (interval: 8, hideBefore: false)),
            SpawnObject(spriteOrAtlas: "Boss4", time: time, type: .boss, speed: 20, health: 65, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, randomMissleShootTimeIntervalRange: (min: 1, max: 5)),
            SpawnObject(spriteOrAtlas: "Boss5", time: time, type: .boss, speed: 20, health: 80, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, charge: (interval: 16, hideBefore: false), minionSpawner: (spriteOrAtlas: "Beatle1", health: 1, minionSpeed: 45, zigZag: false, score: 100, min: 2, max: 5)),
            SpawnObject(spriteOrAtlas: "Boss6", time: time, type: .boss, speed: 20, health: 60, randomShootTimeIntervalRange: (min: 0.5, max: 5), score: 100, charge: (interval: 8, hideBefore: true), minionSpawner: (spriteOrAtlas: "Sperm1", health: 1, minionSpeed: 40, zigZag: false, score: 100, min: 2, max: 5)),
            SpawnObject(spriteOrAtlas: "Boss7", time: time, type: .boss, speed: 20, health: 60, randomShootTimeIntervalRange: (min: 0.5, max: 2), score: 5 , charge: (interval: 8, hideBefore: true), minionSpawner: (spriteOrAtlas: "Jelly1", health: 1, minionSpeed: 35, zigZag: true, score: 100, min: 2, max: 5))
        ]
        
        let start = numbers.index(numbers.startIndex, offsetBy: 0)
        let end = numbers.index(numbers.startIndex, offsetBy: 2)
        let range = start..<end
        
        let number = Int(numbers[range])!
        return bosses[number % bosses.count]
    }
}
