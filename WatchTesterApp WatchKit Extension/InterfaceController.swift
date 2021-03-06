//
//  InterfaceController.swift
//  WatchTesterApp WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 13.10.2021.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var startButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        startButton.setAccessibilityIdentifier("start")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    @IBAction func goToNextScreen() {
        pushController(withName: "TestInterfaceController", context: nil)
    }
    
}
