//
//  ContentView.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-06.
//

import SwiftUI

struct MonthMacView: View {
    @State var currentDate: Date = Date()
    @Binding var items: [ToDoItem_mac]
    @Binding var events: [Events_mac]

    var body: some View {
        VStack {
            DateView(currentDate: $currentDate,events: $events, items: $items)
        }
    }
}

#Preview {
    MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
        .frame(width: 400, height: 500)
}
