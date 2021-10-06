//
//  SettingsController.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 25/01/2021.
//

import Foundation
import WatchKit

class SettingsController: WKInterfaceController {
    
    @IBOutlet weak var sensitivitySlider: WKInterfaceSlider!
    @IBOutlet weak var soundHapticButton: WKInterfaceButton!
    @IBOutlet weak var invertControlsButton: WKInterfaceButton!
    
    var defaults: UserDefaults!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        defaults = UserDefaults.standard
        
        let sensitivity = defaults.float(forKey: "sensitivity")
        sensitivitySlider.setValue(sensitivity)
        
        let soundHapticDisabled = defaults.bool(forKey: "soundHapticDisabled")
        soundHapticButton.setTitle(soundHapticDisabled ? "OFF" : "ON")
        
        let invertedControls = defaults.bool(forKey: "invertedControls")
        invertControlsButton.setTitle(invertedControls ? "ON" : "OFF")

    }
    
    @IBAction func sensitivitySliderChange(_ value: Float) {
        defaults.set(value, forKey: "sensitivity")
    }
    
    @IBAction func soundHapticButtonPress() {
        let soundHapticDisabled = !defaults.bool(forKey: "soundHapticDisabled")
        defaults.set(soundHapticDisabled, forKey: "soundHapticDisabled")
        soundHapticButton.setTitle(soundHapticDisabled ? "OFF" : "ON")
    }
    
    @IBAction func invertControlsButtonPress() {
        let invertedControls = !defaults.bool(forKey: "invertedControls")
        defaults.set(invertedControls, forKey: "invertedControls")
        invertControlsButton.setTitle(invertedControls ? "ON" : "OFF")
    }
}

