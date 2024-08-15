//
//  DataManager.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-14.
//

import CoreData
import Foundation

class ItemDataManager: NSObject, ObservableObject {
    @Published var todos: [ToDoItem_mac] = [ToDoItem_mac]()
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "ToDoItem_mac")
    override init() {
        super.init()
        container.loadPersistentStores {_, _ in}
    }
}
