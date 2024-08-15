//
//  AddToDoViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import SwiftUI

    // add a to do item view 
    struct AddingItemView: View {
        @Binding var viewModel: ToDoItem
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
        }
    }
    struct AddingItemView_Previews: PreviewProvider {
        static var previews: some View {
            AddingItemView(viewModel: .constant(ToDoItem.sampleData[0]))
        }
    }

