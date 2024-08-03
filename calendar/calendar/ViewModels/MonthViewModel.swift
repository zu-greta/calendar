//
//  MonthViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-29.
//

import Foundation

// pulling out the adding views
class MonthViewModel: ObservableObject {
    @Published var showingNewEvent = false
    @Published var showingNewItem = false
    
    init () {}
}
