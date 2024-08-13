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
    @State private var selection = 0

    var body: some View {
        VStack (spacing: 20) {
            DateView(currentDate: $currentDate,events: $events, items: $items)
            //schedule and todo list
            ZStack {
                TabView(selection: $selection) {
                    ScrollView(.vertical) {
                        ScheduleView_mac(events: $events, currentDate: $currentDate)
                    }
                    .tag(0)
                    ScrollView(.vertical) {
                        ToDoListView_mac(items: $items, currentDate: $currentDate)
                    }
                    .tag(1)
                }
                .tabViewStyle(DefaultTabViewStyle())
                //.indexViewStyle
                /*
                HStack(spacing: 9) {
                    ForEach(0..<2) { index in
                        Circle()
                            .fill(index == selection ? Color.indigo : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }*/
                //.padding(.top, 222)
            }
        }
    }
}

#Preview {
    MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
        .frame(width: 600, height: 800)
}
