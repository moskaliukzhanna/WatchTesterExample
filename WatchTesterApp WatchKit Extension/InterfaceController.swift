//
//  InterfaceController.swift
//  watchtest_watchOS WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 02.06.2021.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet weak var tableButton: WKInterfaceButton!
    @IBOutlet weak var kittyImg: WKInterfaceImage!
    
    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func awake(withContext context: Any?) {
//        startButton.setAccessibilityIdentifier("start_button")
        tableButton.setAccessibilityIdentifier("table_button")
//        pickColorButton.setAccessibilityIdentifier("goToColorButton")
//        testSlider.setAccessibilityIdentifier("test_slider")
        kittyImg.setImageNamed("studyCat")
    }
    
//    @IBAction func startConnection() {
//        self.pushController(withName: "PurpleInterfaceController", context: nil)
//    }
    
    @IBAction func goToTable() {
        self.pushController(withName: "EventTableInterfaceController", context: nil)
//        self.pushController(withName: "NextInterfaceController", context: nil)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        WKInterfaceDevice().play(.click)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let value = message["Message"] as? String {
            kittyImg.setImageNamed(value == "selected" ? "studyCat" : "funnyCat")
        }
        
    }
}
