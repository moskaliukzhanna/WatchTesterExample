//
//  EventInterfaceController.swift
//  WatchCountdown WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 1/20/21.
//

import WatchKit
import Foundation


class EventInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var eventImage: WKInterfaceImage!
    @IBOutlet weak var eventCategory: WKInterfaceLabel!
    @IBOutlet weak var eventLabel: WKInterfaceLabel!
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            eventLabel.setText(event.name)
            eventCategory.setText(event.category?.rawValue)
            eventImage.setImage(event.category?.eventImage)
            eventImage.setTintColor(event.category?.eventColor)
            eventCategory.setTextColor(event.category?.eventColor)

            eventLabel.setAccessibilityIdentifier("detailsScreenEventLabel")
            eventCategory.setAccessibilityIdentifier("detailsScreenEventCategory")
            eventImage.setAccessibilityIdentifier("detailsScreenEventImage")
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if let event = context as? Event {
            self.event = event
        }
    }
//
//    private func setupTimer() {
//        eventTimer.setDate(event?.endDate ?? Date())
//        eventTimer.start()
//    }
}
