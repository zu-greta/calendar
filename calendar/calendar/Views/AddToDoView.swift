//
//  AddToDoView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import SwiftUI

struct AddToDoView: View {
    @StateObject var viewModel = AddToDoViewModel()
    @Binding var newEventPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add To Do Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 60)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Location", text: $viewModel.location)
                    .textFieldStyle(DefaultTextFieldStyle())

                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                TextField("Notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: 100)
                    .multilineTextAlignment(.leading)
            }
            HStack {
                Button (action: {withAnimation{viewModel.cancel()
                newEventPresented = false}}, label: {
                    Text("Cancel")
                        .font(.title2.bold())
                        .foregroundColor(.accentColor)
                })
                .padding(.leading)
                Spacer()
                Button (action: {withAnimation{if viewModel.canSave {
                    viewModel.save()
                    newEventPresented = false}
                    else {
                        viewModel.showAlert = true
                    }
                }
                }, label: {
                    Text("Save")
                        .font(.title2.bold())
                        .foregroundColor(.accentColor)
                })
                .padding(.trailing)
                .alert(isPresented: $viewModel.showAlert, content: {
                    Alert(title: Text("Error"), message: Text("Please fill in the title field and select future end date"))
                })
            }
            .padding()
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(newEventPresented: Binding(get: {return true}, set: {_ in }))
    }
}
