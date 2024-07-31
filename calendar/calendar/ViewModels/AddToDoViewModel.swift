//
//  AddToDoViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import Foundation

class AddToDoViewModel: ObservableObject {
    @Published var title = ""
    @Published var location = ""
    @Published var dueDate = Date()
    @Published var notes = ""
    @Published var showAlert = false
    
    init() {}
    func save() {
        guard canSave else {
            return
        }
        let newId = UUID().uuidString
        let newItem = ToDoItem(id: newId, title: title, dueDate: dueDate.timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false)
        
        //TODO: save model in database
        //TODO
    }
    func cancel() {
        //TODO
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
