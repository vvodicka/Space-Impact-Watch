//
//  HighScoreController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 10/05/2021.
//

import Foundation
import WatchKit

class HighScoreController: WKInterfaceController {
    
    @IBOutlet weak var highScoreText: WKInterfaceLabel!
    
    var defaults: UserDefaults!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
        
        let highScore = defaults.integer(forKey: "highScore")
        
        highScoreText.setText("\(highScore)")
    }
    
}
