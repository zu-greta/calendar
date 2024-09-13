//
//  ItemStore_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-09-12.
//


import SwiftUI

@MainActor
class ItemStore_mac: ObservableObject {
    @Published var items: [ToDoItem_mac] = [] //HERE
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("items_mac.data")
    }
    
    func load() async throws {
        let task = Task<[ToDoItem_mac], Error> { //HERE
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let eachItem = try JSONDecoder().decode([ToDoItem_mac].self, from: data) //HERE
            return eachItem
        }
        let items = try await task.value
        self.items = items
    }
    
    func save(items: [ToDoItem_mac]) async throws { //HERE
        let task = Task {
            let data = try JSONEncoder().encode(items)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
