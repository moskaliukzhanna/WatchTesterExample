//
//  EventRowController.swift
//  WatchCountdown
//
//  Created by Zhanna Moskaliuk on 1/19/21.
//

import WatchKit

class AWEventRowController: NSObject {
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var mainSeparator: WKInterfaceSeparator!
    @IBOutlet weak var subtitleLabel: WKInterfaceLabel!
    @IBOutlet weak var mainImage: WKInterfaceImage!
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            
            titleLabel.setText(event.name)
            mainSeparator.setColor(event.category?.eventColor)
            mainImage.setImage(event.category?.eventImage)
            mainImage.setTintColor(event.category?.eventColor)
            subtitleLabel.setText(event.endDateString)
            
            // accessibility ids
            titleLabel.setAccessibilityIdentifier("homeScreenNameLabel")
            mainImage.setAccessibilityIdentifier("homeScreenEventImage")
//            subtitleLabel.setAccessibilityIdentifier("homeScreendateLabel")
        }
    }
}
