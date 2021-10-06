//
//  InterfaceController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 25/11/2020.
//

import WatchKit
import Foundation

class GameController: WKInterfaceController, WKCrownDelegate, InterfaceDelegate, GameControllerDelegate {
    
    @IBOutlet var skInterface: WKInterfaceSKScene!
    var scene: GameScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var playRanked: Bool?
        if let context = context as? Bool, context == true {
            playRanked = context
        }
        
        var levelToLoad: Int?
        var initialScore: Int?
        if let context = context as? (score: Int, level: Int) {
            levelToLoad = context.level
            initialScore = context.score
        }
        
        crownSequencer.delegate = self
        crownSequencer.focus()
        
        if playRanked == true {
            scene = GameScene.newRankedGameScene(interfaceDelegate: self, view: self.contentFrame, gameControllerDelegate: self)
        } else {
            scene = GameScene.newGameScene(interfaceDelegate: self, view: self.contentFrame, gameControllerDelegate: self, level: levelToLoad, initialScore: initialScore)
        }
        
        
        
        // Present the scene
        self.skInterface.presentScene(scene)
        // Use a preferredFramesPerSecond that will maintain consistent frame rate
        self.skInterface.preferredFramesPerSecond = 30
    }
    
    
    func presentGameOverController(context: (score: Int, level: Int, victory: Bool, ranked: Bool)) {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameOverController"], contexts: [context], orientation: .horizontal, pageIndex: 0)
    }
    
    func loadLevel(context : (score: Int, level: Int)) {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [context], orientation: .horizontal, pageIndex: 0)
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        GameScene.player.movePlayer(rotationalDelta: CGFloat(rotationalDelta))
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        scene.onResume()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        scene.setLastPauseTime()
    }
    
    func vibrate(_ type : VibrationType) {
        let soundHapticDisabled = UserDefaults.standard.bool(forKey: "soundHapticDisabled")
        if !soundHapticDisabled, let whHapticType = WKHapticType(rawValue: type.rawValue) {
            WKInterfaceDevice.current().play(whHapticType)
        }
    }
    
    @IBAction func onSwipeRight(_ sender: Any) {
        GameScene.player.fireNuke()
    }
    
    override func willDisappear() {
        scene.setLastPauseTime()
    }
}
