//
//  SelectLevelController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 25/01/2021.
//

import Foundation
import WatchKit

class SelectLevelController: WKInterfaceController {
    
    @IBOutlet weak var level1Button: WKInterfaceButton!
    @IBOutlet weak var level2Button: WKInterfaceButton!
    @IBOutlet weak var level3Button: WKInterfaceButton!
    @IBOutlet weak var level4Button: WKInterfaceButton!
    @IBOutlet weak var level5Button: WKInterfaceButton!
    @IBOutlet weak var level6button: WKInterfaceButton!
    @IBOutlet weak var level7Button: WKInterfaceButton!
    @IBOutlet weak var level8Button: WKInterfaceButton!
    
    var defaults: UserDefaults!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
        
        let level2Unlocked = defaults.bool(forKey: "level2Unlocked")
        level2Button.setEnabled(level2Unlocked)
        
        let level3Unlocked = defaults.bool(forKey: "level3Unlocked")
        level3Button.setEnabled(level3Unlocked)
        
        let level4Unlocked = defaults.bool(forKey: "level4Unlocked")
        level4Button.setEnabled(level4Unlocked)
        
        let level5Unlocked = defaults.bool(forKey: "level5Unlocked")
        level5Button.setEnabled(level5Unlocked)
        
        let level6Unlocked = defaults.bool(forKey: "level6Unlocked")
        level6button.setEnabled(level6Unlocked)
        
        let level7Unlocked = defaults.bool(forKey: "level7Unlocked")
        level7Button.setEnabled(level7Unlocked)
        
        let level8Unlocked = defaults.bool(forKey: "level8Unlocked")
        level8Button.setEnabled(level8Unlocked)
        
    }
    
    @IBAction func level1ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 1)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level2ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 2)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level3ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 3)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level4ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 4)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level5ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 5)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level6ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 6)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level7ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 7)], orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func level8ButtonPressed() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 8)], orientation: .horizontal, pageIndex: 0)
    }
}
