//
//  SetNameController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 10/05/2021.
//

import Foundation
import WatchKit

class SetNameController: WKInterfaceController {
    
    @IBOutlet weak var nameTextField: WKInterfaceTextField!
    
    var name: String?
    var defaults: UserDefaults!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
        
        let name = defaults.string(forKey: "name")
        nameTextField.setText(name)
    }
    
    @IBAction func nameChanged(_ value: NSString?) {
        name = value as String?
    }
    
    @IBAction func saveNameClicked() {
        defaults.set(name, forKey: "name")
        dismiss()
    }
    
}
