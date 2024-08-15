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
    
    var body: some Scene {
        WindowGroup {
            MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
                /*.environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
                .environmentObject(manager2)
                .environment(\.managedObjectContext, manager2.container.viewContext)*/
        }
    }
}
