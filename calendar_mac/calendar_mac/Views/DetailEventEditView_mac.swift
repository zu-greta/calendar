//
//  DetailEventEditView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

//editing an event
struct DetailEventEditView_mac: View {
    @Binding var event: Events_mac
    
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

#Preview {
    DetailEventEditView_mac(event: .constant(Events_mac.sampleData[0]))
}
