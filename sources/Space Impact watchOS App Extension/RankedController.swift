//
//  RankedController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 05/05/2021.
//

import Foundation
import WatchKit

class RankedController: WKInterfaceController {
    
    var defaults: UserDefaults!
    
    @IBOutlet weak var toprankedScoreLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
    }
    
    override func willActivate() {
        let rankedHighScore = defaults.integer(forKey: "rankedHighScore")
        toprankedScoreLabel.setText(String(rankedHighScore))
    }
    
    @IBAction func playButtonClicked() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(true)], orientation: .horizontal, pageIndex: 0)
    }
}
