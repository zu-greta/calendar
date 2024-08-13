//
//  ItemDetailView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

// editing item detailed view (+delete an item)
struct ItemDetailView_mac: View {
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
                            }
                        }
                    }
            }
        })
    }
}


#Preview {
    ItemDetailView_mac(item: .constant(ToDoItem_mac.sampleData[0]))
}
