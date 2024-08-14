//
//  DataManager.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-14.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "MonthMacView")
    override init() {
        super.init()
        container.loadPersistentStores {_, _ in}
    }
}
