//
//  Events.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

struct Events: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}
struct EventsMetaData: Identifiable {
    var id = UUID().uuidString
    var event: [Events]
    var eventDate: Date
}
//for testing
//TODO: replace with user actual data
func getSampleDate(offset:Int)->Date{
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}
var events: [EventsMetaData] = [
    EventsMetaData(event: [
    Events(title: "finish project"), Events(title: "learn dance")], eventDate: getSampleDate(offset: 1)),
    EventsMetaData(event: [Events(title: "dragonboat")], eventDate: getSampleDate(offset: -3)),
    EventsMetaData(event: [Events(title: "book")], eventDate: getSampleDate(offset: -8)),
    EventsMetaData(event: [Events(title: "food")], eventDate: getSampleDate(offset: 10)),
    EventsMetaData(event: [Events(title: "build a plane")], eventDate: getSampleDate(offset: 15)),
]
