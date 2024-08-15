//
//  DataManager2.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-14.
//

import CoreData
import Foundation

class EventDataManager: NSObject, ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Events_mac")
    override init() {
        super.init()
        container.loadPersistentStores {_, _ in}
    }
}
