//
//  ToDoItem.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import Foundation

struct ToDoItem: Codable, Identifiable {
    let id: UUID
    var title: String
    var dueDate: TimeInterval
    var createdDate: TimeInterval
    var notes: String
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    init(id: UUID=UUID(), title: String, dueDate: TimeInterval, createdDate: TimeInterval, notes: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.createdDate = createdDate
        self.notes = notes
        self.isDone = isDone
    }
    
    static var emptyItem: ToDoItem {
        ToDoItem(title: "", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notes: "", isDone: false)
    }
}

func date(from timeInterval: TimeInterval) -> Date {
    return Date(timeIntervalSince1970: timeInterval)
}

func getSample(offset: Int) -> TimeInterval {
    let calendar = Calendar.current
    if let date = calendar.date(byAdding: .day, value: offset, to: Date()) {
        return date.timeIntervalSince1970
    } else {
        return Date().timeIntervalSince1970
    }
}

extension ToDoItem {
    static let sampleData: [ToDoItem] =
    [
        ToDoItem(title: "a", dueDate: getSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n1", isDone: false),
        ToDoItem(title: "b", dueDate: getSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n2", isDone: true),
    ]
}

