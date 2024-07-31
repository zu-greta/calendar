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
    @StateObject var todoModel = MonthViewModel()
    @State private var selection = 0
    
    var body: some View {
        //TODO: add more functions in toolbar
        NavigationView {
            VStack (spacing: 20){
                MyDatePicker(currentDate: $currentDate)
                ZStack {
                    TabView(selection: $selection) {
                        ScrollView(.vertical) {
                            ScheduleView(currentDate: $currentDate)
                        }
                        .tag(0)
                        ScrollView(.vertical) {
                            ToDoListView(currentDate: $currentDate)
                        }
                        .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                    
                     HStack(spacing: 8) {
                         ForEach(0..<2) { index in
                             Circle()
                                 .fill(index == selection ? Color.indigo : Color.gray)
                                 .frame(width: 8, height: 8)
                         }
                     }
                     .padding(.top, 205)
                }
            }
            .toolbar {
                ToolbarItemGroup (placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Menu ("+") {
                            Button("Add Event", action: {viewModel.showingNewEvent = true})
                            //TODO: action for to do list new item
                            Button("Add ToDo Item", action: {viewModel.showingNewItem = true})
                        }
                        .font(.largeTitle)
                        .padding(.trailing, 10)
                        .padding(.top, 20)
                    }
                    .sheet(isPresented: $viewModel.showingNewEvent) {
                        AddEventView(newEventPresented: $viewModel.showingNewEvent)
                    }
                    .sheet(isPresented: $viewModel.showingNewItem) {
                        AddToDoView(newEventPresented: $viewModel.showingNewItem)
                    }
                }
            }
            //TODO: add functions to toolbar items
            .toolbar {
                ToolbarItemGroup (placement: .topBarLeading) {
                    Spacer()
                    Text("Alarms")
                    Spacer()
                    Text("Notes")
                    Spacer()
                    Text("Health")
                    Spacer()
                    Text("Calendar")
                    Spacer()
                    Text("Travel")
                }
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}

/*
 HStack {
     Text("Calendar")
     Spacer()
     Menu ("calendars") {
         Button("calendar0", action: {})
         Button("calendar1", action: {})
     }
 }
 
 Button (action: {viewModel.showingNewEvent = true}, label: {
     Image(systemName: "plus")
         .font(.title2)
         .foregroundColor(.accentColor)
 })
 
 Button (action: viewModel.showingNewEvent = true, label: {
     Label("Add Event", systemImage: "calendar.badge.plus")
 })
 Button(action: {}, label: {
     Label("Add ToDo Item", systemImage: "text.badge.plus")
 })
 */
