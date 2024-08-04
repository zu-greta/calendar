//
//  itemDetailView.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-02.
//

import SwiftUI

// editing item detailed view (+delete an item)
struct ItemDetailView: View {
    @Binding var item: ToDoItem
    var deleteAction: (() -> Void)?
    @State private var editingItem = ToDoItem.emptyItem
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
            ToolbarItem(placement: .topBarTrailing) { 
                Button("Edit") {
                    isPresentingEditView = true
                    editingItem = item
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationView {
                DetailItemEditView(item: $editingItem)
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
                            }
                        }
                    }
            }
        })
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetailView(item: .constant(ToDoItem.sampleData[0]))
        }
    }
}
