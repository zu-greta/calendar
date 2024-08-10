//
//  ToDoItem_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import Foundation

//items
struct ToDoItem_mac: Codable, Identifiable {
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
    
    static var emptyItem: ToDoItem_mac {
        ToDoItem_mac(title: "", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, notes: "", isDone: false)
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

extension ToDoItem_mac {
    static let sampleData: [ToDoItem_mac] =
    [
        ToDoItem_mac(title: "a", dueDate: getSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n1", isDone: false),
        ToDoItem_mac(title: "b", dueDate: getSample(offset: 0), createdDate: Date().timeIntervalSince1970, notes: "n2", isDone: true),
        ToDoItem_mac(title: "v", dueDate: getSample(offset: 1), createdDate: Date().timeIntervalSince1970, notes: "n2", isDone: true),
        ToDoItem_mac(title: "aa", dueDate: getSample(offset: -1), createdDate: Date().timeIntervalSince1970, notes: "n1", isDone: false),
    ]
}
