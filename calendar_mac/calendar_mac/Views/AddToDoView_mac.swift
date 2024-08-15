//
//  AddToDoView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-13.
//

import SwiftUI

// add a to do item view (goes to adding item view)
struct AddToDoView_mac: View {
    @State private var addItem = ToDoItem_mac.emptyItem
    @Binding var items: [ToDoItem_mac]
    @Binding var newEventPresented: Bool
    
    //COREDATA
    @EnvironmentObject var manager: ItemDataManager
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationStack {
            AddingItemView_mac(viewModel: $addItem)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            newEventPresented = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            items.append(addItem)
                            newEventPresented = false
                        }
                    }
                }
                .padding(.leading)
                .padding(.trailing)
        }
    }
}

#Preview {
    AddToDoView_mac(items: .constant(ToDoItem_mac.sampleData), newEventPresented: .constant(true))
}
