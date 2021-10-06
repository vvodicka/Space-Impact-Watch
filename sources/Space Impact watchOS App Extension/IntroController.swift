//
//  IntroController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 25/01/2021.
//

import Foundation
import WatchKit

class IntroController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //debug - startuj rovno level
        //WKInterfaceController.reloadRootPageControllers(withNames: ["GameController"], contexts: [(score: 0, level: 7)], orientation: .horizontal, pageIndex: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
           WKInterfaceController.reloadRootPageControllers(withNames: ["MenuController"], contexts: nil, orientation: .horizontal, pageIndex: 0)
        }
    }
    
}
