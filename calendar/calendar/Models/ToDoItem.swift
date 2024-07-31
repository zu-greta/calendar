//
//  ToDoItem.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import Foundation

struct ToDoItem: Codable, Identifiable{
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}

struct ToDoMetaData: Identifiable {
    var id = UUID().uuidString
    var item: [ToDoItem]
    var itemDate: Date
}
func date(from timeInterval: TimeInterval) -> Date {
    return Date(timeIntervalSince1970: timeInterval)
}
//for testing
//TODO: replace with user actual data
// Function to generate a sample date as a TimeInterval
func getSample(offset: Int) -> TimeInterval {
    let calendar = Calendar.current
    if let date = calendar.date(byAdding: .day, value: offset, to: Date()) {
        return date.timeIntervalSince1970
    } else {
        return Date().timeIntervalSince1970
    }
}
var ToDoItems: [ToDoMetaData] = [
    ToDoMetaData(item: [ToDoItem(id: UUID().uuidString, title: "Finish project", dueDate: getSample(offset: 0), createdDate: Date().timeIntervalSince1970, isDone: false)], itemDate: date(from: getSample(offset: 0))),
    ToDoMetaData(item: [ToDoItem(id: UUID().uuidString, title: "Learn dance", dueDate: getSample(offset: 2), createdDate: Date().timeIntervalSince1970, isDone: false)], itemDate: date(from: getSample(offset: 2))),
    ToDoMetaData(item: [ToDoItem(id: UUID().uuidString, title: "Buy groceries", dueDate: getSample(offset: 3), createdDate: Date().timeIntervalSince1970, isDone: false)], itemDate: date(from: getSample(offset: 3))),
    ToDoMetaData(item: [ToDoItem(id: UUID().uuidString, title: "Dragonboat practice", dueDate: getSample(offset: -1), createdDate: Date().timeIntervalSince1970, isDone: true)], itemDate: date(from: getSample(offset: -1))),
]


