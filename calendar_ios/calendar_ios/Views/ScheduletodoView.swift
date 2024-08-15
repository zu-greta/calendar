//
//  ScheduletodoView.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-03.
//

import SwiftUI

struct ScheduletodoView: View {
    @State var currentDate: Date = Date()
    @StateObject var viewModel = MonthViewModel()
    @State private var selection = 0
    @Binding var items: [ToDoItem]
    @Binding var events: [Events]
    @Binding var newEventPresented: Bool
    
    var body: some View {
        VStack {
            Button(action: {newEventPresented = false}) {
                Image(systemName: "chevron.down").font(.title3)
            }
            .padding(.top, 30)
            ZStack {
                TabView(selection: $selection) {
                    ScrollView(.vertical) {
                        ScheduleView(events: $events, currentDate: $currentDate)
                    }
                    .tag(0)
                    ScrollView(.vertical) {
                        ToDoListView(items: $items, currentDate: $currentDate)

                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                
                 HStack(spacing: 9) {
                     ForEach(0..<2) { index in
                         Circle()
                             .fill(index == selection ? Color.indigo : Color.gray)
                             .frame(width: 8, height: 8)
                     }
                 }
                 .padding(.top, 651)
            }
            .padding(.top)
        }
    }
}

struct ScheduletodoView_Previews : PreviewProvider {
    static var previews: some View {
        ScheduletodoView(items: .constant(ToDoItem.sampleData), events: .constant(Events.sampleData), newEventPresented: .constant(true))
    }
}
