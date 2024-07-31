//
//  MonthViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import Foundation

class AddEventViewModel: ObservableObject {
    @Published var title = ""
    @Published var location = ""
    @Published var endDate = Date()
    @Published var startDate = Date()
    @Published var notes = ""
    @Published var showAlert = false
    
    init() {}
    func save() {
        //TODO
    }
    func cancel() {
        //TODO
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard endDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
