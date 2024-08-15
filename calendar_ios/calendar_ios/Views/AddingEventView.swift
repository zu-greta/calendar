//
//  MonthViewModel.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

//add an event view
struct AddingEventView: View {
    @Binding var viewModel: Events
    @State private var newEventTitle = ""

    private var startTime: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: self.viewModel.startTime) },
                set: { self.viewModel.startTime = $0.timeIntervalSince1970 }
            )
        }
    private var endTime: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: self.viewModel.endTime) },
                set: { self.viewModel.endTime = $0.timeIntervalSince1970 }
            )
        }
    
    var body: some View {
        VStack {
            Text("Add Event")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 20)
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Location", text: $viewModel.location)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                DatePicker("Starts", selection: startTime)
                    .datePickerStyle(DefaultDatePickerStyle())
                DatePicker("Ends", selection: endTime)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                //TODO: dynamic drop down menu for calendars and add action for buttons
                /*
                HStack {
                    Text("Calendar")
                    Spacer()
                    Menu ("calendars") {
                        Button("calendar0", action: {})
                        Button("calendar1", action: {})
                    }
                }
                */
                TextField("Notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .frame(height: 100)
                    .multilineTextAlignment(.leading)
            }
        }

    }
}

struct AddingEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddingEventView(viewModel: .constant(Events.sampleData[0]))
    }
}


