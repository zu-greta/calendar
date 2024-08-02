//
//  AddToDoView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import SwiftUI

struct AddToDoView: View {
    @State private var addItem = ToDoItem.emptyItem
    @Binding var items: [ToDoItem]
    @Binding var newEventPresented: Bool
    
    var body: some View {
        NavigationStack {
            AddingItemView(viewModel: $addItem)
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
            
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(items: .constant(ToDoItem.sampleData), newEventPresented: .constant(true))
    }
}
