//
//  calendar_macApp.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-06.
//

import SwiftUI

@main
struct calendar_macApp: App {
    //@StateObject private var manager: ItemDataManager = ItemDataManager()
    //@StateObject private var manager2: EventDataManager = EventDataManager()
    @StateObject private var store_mac = ItemStore_mac()
    @StateObject private var eventStore_mac = EventStore_mac()
    
    var body: some Scene {
        WindowGroup {
            /*MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
                .environmentObject(manager2)
                .environment(\.managedObjectContext, manager2.container.viewContext)*/
            MonthMacView(items: $store_mac.items, events: $eventStore_mac.events) {
                Task {
                    do {
                        try await store_mac.save(items: store_mac.items)
                        try await eventStore_mac.save(events: eventStore_mac.events)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                }
            .task {
                do {
                    try await store_mac.load()
                    try await eventStore_mac.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            
            
                
        }
    }
}
