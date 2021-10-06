//
//  LeaderBoardController.swift
//  Space Impact iOS
//
//  Created by Vladislav Vodicka on 07/05/2021.
//

import UIKit
import SwiftUI

class LeaderBoardController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: LeaderBoardView())
        addChild(childView)
        childView.view.frame = view.bounds
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
}
