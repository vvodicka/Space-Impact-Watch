//
//  UploadToLeaderboardController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 18/05/2021.
//

import Foundation
import WatchKit

class UploadToLeaderBoardController: WKInterfaceController {
    
    var defaults: UserDefaults!
    let connectivityProvider = WatchConnectivityProvider()
        
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var closeButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
    }
    
    override func willActivate() {
        label.setText("Open your iPhone application in order to upload high score to leader board")
        closeButton.setHidden(true)
        
        let rankedHighScore = defaults.integer(forKey: "rankedHighScore")
        
        connectivityProvider.sendScore(score: rankedHighScore) { success in
            if success {
                self.label.setText("High score upload successful")
            } else {
                self.label.setText("High score upload failed")
            }
            
            self.closeButton.setHidden(false)
        }
    }
    
    @IBAction func closeButtonClicked() {
        dismiss()
    }
}
