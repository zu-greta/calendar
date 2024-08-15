//
//  calendar_iosApp.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

@main
struct calendar_iosApp: App {
    @StateObject private var store = ItemStore()
    @StateObject private var eventStore = EventStore()
    
    var body: some Scene {
        WindowGroup {
            MonthView(items: $store.items, events: $eventStore.events) {
                Task {
                    do {
                        try await store.save(items: store.items)
                        try await eventStore.save(events: eventStore.events)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                        try await eventStore.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
