//
//  ItemDetailView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI
import CoreData

// Editing item detailed view (+delete an item)
struct ItemDetailView_mac: View {
    //COREDATA
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var item: ToDoItem_mac
    var deleteAction: (() -> Void)?
    @State private var editingItem = ToDoItem_mac.emptyItem
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Event info")) {
                HStack {
                    Text("Title: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(item.title)")
                }
                HStack {
                    Text("Due: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                }
                HStack {
                    Text("Notes: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(item.notes)")
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete") {
                    deleteAction?()
                }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .automatic) { // topBarTrailing
                Button("Edit") {
                    isPresentingEditView = true
                    editingItem = item
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailItemEditView_mac(item: $editingItem)
                    .navigationTitle(editingItem.title ?? "")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                updateItem()
                            }
                        }
                    }
            }
        }
    }

    private func updateItem() {
        item.title = editingItem.title
        item.dueDate = editingItem.dueDate
        item.notes = editingItem.notes
        item.isDone = editingItem.isDone
        item.createdDate = editingItem.createdDate

        do {
            try viewContext.save()
            print("Todo item updated")
        } catch {
            print("Saving error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ItemDetailView_mac(item: .constant(ToDoItem_mac.sampleData[0]))
}



/*
import SwiftUI

// editing item detailed view (+delete an item)
struct ItemDetailView_mac: View {
    //COREDATA
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var item: ToDoItem_mac
    var deleteAction: (() -> Void)?
    @State private var editingItem = ToDoItem_mac.emptyItem
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Event info")) {
                HStack {
                    Text("Title: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(item.title)")
                }
                HStack {
                    Text("Due: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                }
                HStack {
                    Text("Notes: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(item.notes)")
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete") {
                    deleteAction?()
                }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .automatic) { //topBarTrailing
                Button("Edit") {
                    isPresentingEditView = true
                    editingItem = item
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationView {
                DetailItemEditView_mac(item: $editingItem)
                    .navigationTitle(item.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                item = editingItem
                                self.saveItem(item: $editingItem)
                            }
                        }
                    }
            }
        })
    }
    func saveItem(item: ToDoItem_mac) {
        let todo = ToDoItem_mac(context: self.viewContext)
        todo.id = UUID()
        todo.title = item.title
        todo.dueDate = item.dueDate
        todo.notes = item.notes
        todo.isDone = item.isDone
        todo.createdDate = item.createdDate
        
        do {
            try self.viewContext.save()
            print("Todo item saved")
        } catch {
            print("saving error \(error.localizedDescription)")
        }
    }
}


#Preview {
    ItemDetailView_mac(item: .constant(ToDoItem_mac.sampleData[0]))
}
*/
