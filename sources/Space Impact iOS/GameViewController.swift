//
//  GameViewController.swift
//  Space Impact iOS
//
//  Created by Vladislav Vodicka on 05/05/2021.
//

import UIKit
import SwiftUI

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: HelpAndSettingsView())
        addChild(childView)
        childView.view.frame = view.bounds
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
}
