//
//  MonthViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-29.
//

import Foundation

class MonthViewModel: ObservableObject {
    @Published var showingNewEvent = false
    @Published var showingNewItem = false
    
    init () {}
}
