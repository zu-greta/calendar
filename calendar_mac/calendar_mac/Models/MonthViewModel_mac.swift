//
//  MonthViewModel_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-13.
//

import Foundation

// pulling out the adding views
class MonthViewModel_mac: ObservableObject {
    @Published var showingNewEvent = false
    @Published var showingNewItem = false
    @Published var showingScheduleTodoView = false
    
    init () {}
}
