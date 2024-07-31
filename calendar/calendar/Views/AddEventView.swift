//
//  AddEventView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

struct AddEventView: View {
    @StateObject var viewModel = AddEventViewModel()
    @Binding var newEventPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add Event")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 60)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Location", text: $viewModel.location)
                    .textFieldStyle(DefaultTextFieldStyle())

                DatePicker("Starts", selection: $viewModel.startDate)
                    .datePickerStyle(DefaultDatePickerStyle())
                DatePicker("Ends", selection: $viewModel.endDate)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                //TODO: dynamic drop down menu for calendars and add action for buttons
                HStack {
                    Text("Calendar")
                    Spacer()
                    Menu ("calendars") {
                        Button("calendar0", action: {})
                        Button("calendar1", action: {})
                    }
                }
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

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(newEventPresented: Binding(get: {return true}, set: {_ in }))
    }
}
