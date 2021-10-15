//
//  ViewController.swift
//  WatchTesterExample
//
//  Created by Zhanna Moskaliuk on 05.10.2021.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    
    @IBOutlet weak var catSwitch: UISwitch!
    var selected = true
    
    @IBAction func switchCat(_ value: Bool) {
//        switch value {
//        case true:
//            sendMessage(message: "selected")
//        case false:
//            sendMessage(message: "unselected")
//        }
        selected.toggle()
        if selected {
            sendMessage(message: "selected")
        } else {
            sendMessage(message: "unselected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendMessage(message: String) {
        if (WCSession.default.isReachable) {
            let messDict = ["Message" : message]
            WCSession.default.sendMessage(messDict, replyHandler: nil)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    
}

