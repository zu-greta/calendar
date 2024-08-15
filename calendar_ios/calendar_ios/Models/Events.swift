//
//  Events.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import Foundation

//events
struct Events: Identifiable, Codable {
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
    static var emptyEvent: Events {
        Events(title: "", location: "", startTime: Date().timeIntervalSince1970, endTime: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notes: "")
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

extension Events {
    static let sampleData: [Events] =
    [
        Events(title: "e", location: "here", startTime: getEventSample(offset: 0), endTime: getEventSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events(title: "d", location: "there", startTime: getEventSample(offset: 0), endTime: getEventSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events(title: "f", location: "elsewhere",  startTime: getEventSample(offset: 2), endTime: getEventSample(offset: 2), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events(title: "g", location: "elsewhere",  startTime: getEventSample(offset: -1), endTime: getEventSample(offset: 1), createdDate: Date().timeIntervalSince1970, notes: "n3"),
        Events(title: "ggg", location: "elsewhere",  startTime: getEventSample(offset: 4), endTime: getEventSample(offset: 8), createdDate: Date().timeIntervalSince1970, notes: "n3"),

    ]
}


