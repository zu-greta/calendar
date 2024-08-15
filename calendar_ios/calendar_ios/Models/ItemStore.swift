//
//  ItemStore.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-01.
//

import SwiftUI

@MainActor
class ItemStore: ObservableObject {
    @Published var items: [ToDoItem] = [] //HERE
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("items.data")
    }
    
    func load() async throws {
        let task = Task<[ToDoItem], Error> { //HERE
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let eachItem = try JSONDecoder().decode([ToDoItem].self, from: data) //HERE
            return eachItem
        }
        let items = try await task.value
        self.items = items
    }
    
    func save(items: [ToDoItem]) async throws { //HERE
        let task = Task {
            let data = try JSONEncoder().encode(items)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
