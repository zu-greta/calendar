//
//  DetailEventEditView.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-02.
//

import SwiftUI

//editing an event
struct DetailEventEditView: View {
    @Binding var event: Events
    
    var body: some View {
        
        Form {
            Section(header: Text("Event info")) {
                TextField("Title", text: $event.title)
                TextField("Location", text: $event.location)
                DatePicker("Starts", selection: startTimeBinding)
                DatePicker("Ends", selection: endTimeBinding)
                //TODO: dynamic calendar change????
                /*HStack {
                    Text("Calendar")
                    Spacer()
                    Menu ("calendars") {
                        Button("calendar0", action: {})
                        Button("calendar1", action: {})
                    }
                }
                */
                TextField("Notes", text: $event.notes)
            }
        }
    }
    private var startTimeBinding: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: event.startTime) },
                set: { event.startTime = $0.timeIntervalSince1970 }
            )
        }
    private var endTimeBinding: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: event.endTime) },
                set: { event.endTime = $0.timeIntervalSince1970 }
            )
        }
}

struct DetailEventEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEventEditView(event: .constant(Events.sampleData[0]))
    }
}
