//
//  EventStore_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-09-12.
//

import SwiftUI

@MainActor
class EventStore_mac: ObservableObject {
    @Published var events: [Events_mac] = [] //HERE
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("events_mac.data")
    }
    
    func load() async throws {
        let task = Task<[Events_mac], Error> { //HERE
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let eachEvent = try JSONDecoder().decode([Events_mac].self, from: data) //HERE
            return eachEvent
        }
        let events = try await task.value
        self.events = events
    }
    
    func save(events: [Events_mac]) async throws { //HERE
        let task = Task {
            let data = try JSONEncoder().encode(events)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
