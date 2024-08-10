//
//  Events_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import Foundation

//events
struct Events_mac: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String
    var location: String
    var startTime: TimeInterval
    var endTime: TimeInterval
    var createdDate: TimeInterval
    var notes: String
    
    init(id: String = UUID().uuidString, title: String, location: String, startTime: TimeInterval, endTime: TimeInterval, createdDate: TimeInterval, notes: String) {
        self.id = id
        self.title = title
        self.location = location
        self.startTime = startTime
        self.endTime = endTime
        self.createdDate = createdDate
        self.notes = notes
    }
    static var emptyEvent: Events_mac {
        Events_mac(title: "", location: "", startTime: Date().timeIntervalSince1970, endTime: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notes: "")
    }
}

func getEventSample(offset: Int) -> TimeInterval {
    let calendar = Calendar.current
    if let date = calendar.date(byAdding: .day, value: offset, to: Date()) {
        return date.timeIntervalSince1970
    } else {
        return Date().timeIntervalSince1970
    }
}
func dateEvent(from timeInterval: TimeInterval) -> Date {
    return Date(timeIntervalSince1970: timeInterval)
}

extension Events_mac {
    static let sampleData: [Events_mac] =
    [
        Events_mac(title: "e", location: "here", startTime: getEventSample(offset: 0), endTime: getEventSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events_mac(title: "d", location: "there", startTime: getEventSample(offset: 0), endTime: getEventSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events_mac(title: "f", location: "elsewhere",  startTime: getEventSample(offset: 2), endTime: getEventSample(offset: 2), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events_mac(title: "g", location: "elsewhere",  startTime: getEventSample(offset: -1), endTime: getEventSample(offset: 1), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events_mac(title: "ggg", location: "elsewhere",  startTime: getEventSample(offset: 4), endTime: getEventSample(offset: 8), createdDate: Date().timeIntervalSince1970, notes: "n3"),

    ]
}
