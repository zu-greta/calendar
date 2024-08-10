//
//  DateValue.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-08.
//

import SwiftUI

struct DateValue_mac: Identifiable, Codable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
