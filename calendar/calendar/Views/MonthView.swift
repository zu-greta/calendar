//
//  MonthView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

struct MonthView: View {
    @State var currentDate: Date = Date()
    @StateObject var viewModel = MonthViewModel()
    @State private var selection = 0
    
    @Binding var items: [ToDoItem]
    @Binding var events: [Events]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
        
    var body: some View {
        NavigationView {
            VStack (spacing: 20){
                //calendar month view
                MyDatePicker(currentDate: $currentDate, events: $events, items: $items)
                //TODO: add arrow button to pull up the schedule/todo view -> change to week instead of month view for the calendar
                //schedule and to do list view
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
                     .padding(.top, 199)
                }
            }
            // adding a to do item or event
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Menu("+") {
                        Button("Add Event") { viewModel.showingNewEvent = true }
                        Button("Add ToDo Item") { viewModel.showingNewItem = true }
                    }
                    .font(.largeTitle)
                    .padding(.trailing, 10)
                    .padding(.top, 20)
                }
            }
            .sheet(isPresented: $viewModel.showingNewEvent) {
                AddEventView(events: $events, newEventPresented: $viewModel.showingNewEvent)
            }
            .sheet(isPresented: $viewModel.showingNewItem) {
                AddToDoView(items: $items, newEventPresented: $viewModel.showingNewItem)
            }
            .onChange(of: scenePhase) {
                phase in
                if phase == .inactive {saveAction()}
            }
            //TODO: add functions to toolbar items
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("Alarms").padding(.horizontal)
                            Text("Notes").padding(.horizontal)
                            Text("Health").padding(.horizontal)
                            Text("Calendar").padding(.horizontal)
                            Text("Travel").padding(.horizontal)
                        }
                        
                    }
                    
                }
            }
            .padding(.top)
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(items: .constant(ToDoItem.sampleData), events: .constant(Events.sampleData), saveAction: {})
    }
}
