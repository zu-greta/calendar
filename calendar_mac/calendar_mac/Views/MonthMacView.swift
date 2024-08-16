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
    @StateObject var viewModel = MonthViewModel_mac()
    
    //COREDATA
    //@FetchRequest(sortDescriptors: []) private var todos: FetchedResults<CDItem_mac>

    var body: some View {
        //NavigationSplitView{}
        NavigationStack{
            VStack (spacing: 20) {
                DateView(currentDate: $currentDate,events: $events, items: $items)
                //DateView(currentDate: $currentDate,events: $events, items: todos)
                //schedule and todo list
                ZStack {
                    TabView(selection: $selection) {
                        ScrollView(.vertical) {
                            ScheduleView_mac(events: $events, currentDate: $currentDate)
                        }
                        .tag(0)
                        ScrollView(.vertical) {
                            ToDoListView_mac(items: $items, currentDate: $currentDate)
                            //ToDoListView_mac(items: todos, currentDate: $currentDate)
                        }
                        .tag(1)
                    }
                    .tabViewStyle(DefaultTabViewStyle())
                }
            }
            // adding a to do item or event
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Menu("apps") {
                        Button("Alarms") {  }
                        Button("Notes") {  }
                        Button("Health") {  }
                        Button("Calendar") {  }
                    }
                    .font(.title2)
                    .padding(.leading, 10)
                    .padding(.top, 20)
                    
                }
                //TODO: add functions to toolbar items
                ToolbarItemGroup(placement: .automatic) {
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
                AddEventView_mac(events: $events, newEventPresented: $viewModel.showingNewEvent)
            }
            .sheet(isPresented: $viewModel.showingNewItem) {
                AddToDoView_mac(items: $items, newEventPresented: $viewModel.showingNewItem)
            }
            /*
             .onChange(of: $viewModel) {
             newTodo in self.todos.nsPredicate = newTodo.isEmpty ? nil : NSPredicate(format: "title CONTAINS %@", newTodo)
             }*/
        }
    }
}

#Preview {
    MonthMacView(items: .constant(ToDoItem_mac.sampleData), events: .constant(Events_mac.sampleData))
        .frame(width: 700, height: 800)
}
