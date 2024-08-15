//
//  DateValue.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

//date
struct DateValue: Identifiable, Codable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

