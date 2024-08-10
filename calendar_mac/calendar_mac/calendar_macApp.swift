//
//  calendar_macApp.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-06.
//

import SwiftUI

@main
struct calendar_macApp: App {
    var body: some Scene {
        WindowGroup {
            MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
        }
    }
}
