//
//  GameOverController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 25/01/2021.
//

import Foundation
import WatchKit

class GameOverController: WKInterfaceController {
    
    @IBOutlet weak var gameOverLabel: WKInterfaceLabel!
    @IBOutlet weak var continueButton: WKInterfaceButton!
    
    private var level: Int!
    
    var defaults: UserDefaults!
    
    let connectivityProvider = WatchConnectivityProvider()
    
    override func willActivate() {
       
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
        
        let highScore = defaults.integer(forKey: "highScore")
        let rankedHighScore = defaults.integer(forKey: "rankedHighScore")

        if let context = context as? (score: Int, level: Int, victory: Bool, ranked: Bool) {
            if context.victory {
                gameOverLabel.setText("Victory!\nYour score:\n\(context.score)")
                continueButton.setHidden(true)
            } else {
                gameOverLabel.setText("Game Over!\nYour score:\n\(context.score)")
                self.level = context.level
            }
            
            if context.score > highScore && context.ranked != true {
                defaults.set(context.score, forKey: "highScore")
            }
            
            if context.score > rankedHighScore && context.ranked == true {
                defaults.set(context.score, forKey: "rankedHighScore")
                
                self.presentController(withName: "uploadToLeaderBoard", context: nil)
            }
            
            if context.ranked == true {
                continueButton.setHidden(true)
            }

        }
    }
    
    @IBAction func continueButtonPress() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: self.level)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func quitButtonPress() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["MenuController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
}
