//
//  Event.swift
//  WristyCountdown
//
//  Created by Tamara on 24/09/2019.
//  Copyright © 2019 Tamara. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    case study = "Study"
    case vacation = "Vacation"
    case birthday = "Birthday"
    case event = "Event"
    
    var eventImage: UIImage? {
        switch self {
        case .study:
            return UIImage(named: "studyCat")
        case .vacation:
            return UIImage(named: "vacationCat")
        case .birthday:
            return UIImage(named: "giftCat")
        case .event:
            return UIImage(named: "funnyCat")
        }
    }
    
    var eventColor: UIColor {
        switch self {
        case .study:
            return UIColor.lightGray
        case .vacation:
            return UIColor.yellow
        case .birthday:
            return UIColor.green
        case .event:
            return UIColor.purple
        }
    }
}

class Event {
    
    var name: String = ""
    var categoryRaw: String = ""
    var endDateString: String = ""
    
    var category: Category? {
        return Category(rawValue: categoryRaw)
    }
    
    var endDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        return dateFormatter.date(from: endDateString)
    }
    
    class func allEvents() -> [Event] {
        var events: [Event] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let path = Bundle.main.path(forResource: "Events", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return events
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
            json.forEach({ (dict: [String: String]) in
                events.append(Event(dictionary: dict, formatter: formatter))
            })
        } catch let error as NSError {
            print(error)
        }
        
        return events
    }
    
    init(name: String, category: String, endDate: String) {
        self.name = name
        self.categoryRaw = category
        self.endDateString = endDate
    }
    
    convenience init(dictionary: [String: String], formatter: DateFormatter) {
        let name = dictionary["name"]!
        let categoryRaw = dictionary["category"]!
        let endDateString = dictionary["endDate"]!
        self.init(name: name, category: categoryRaw, endDate: endDateString)
    }
    
}
