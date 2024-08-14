//
//  AddingItemView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-13.
//

import SwiftUI

// add a to do item view
struct AddingItemView_mac: View {
    @Binding var viewModel: ToDoItem_mac
    @State private var newItemTitle = ""
    
    private var dueDate: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: viewModel.dueDate) },
                set: { viewModel.dueDate = $0.timeIntervalSince1970 }
            )
        }
    
    var body: some View {
        VStack {
            Text("Add To Do Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 20)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())

                DatePicker("Due Date", selection: dueDate)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                TextField("Notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: 100)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

#Preview {
    AddingItemView_mac(viewModel: .constant(ToDoItem_mac.sampleData[0]))
}
