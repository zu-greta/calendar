//
//  EventDetailView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

// editing event detailed view (+ delete an event)
struct EventDetailView_mac: View {
    @Binding var event: Events_mac
    var deleteAction: (() -> Void)?
    @State private var editingEvent = Events_mac.emptyEvent
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Event info")) {
                HStack {
                    Text("Title: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(event.title)")
                }
                HStack {
                    Text("Location: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(event.location)")
                }
                HStack {
                    Text("Start date: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Date(timeIntervalSince1970: event.startTime).formatted(date: .abbreviated, time: .shortened))")
                }
                HStack {
                    Text("End date: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(Date(timeIntervalSince1970: event.endTime).formatted(date: .abbreviated, time: .shortened))")
                }
                HStack {
                    Text("Notes: ")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(event.notes)")
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
                    editingEvent = event
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationView {
                DetailEventEditView_mac(event: $editingEvent)
                    .navigationTitle(event.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                event = editingEvent
                            }
                        }
                    }
            }
        })
    }
}


#Preview {
    EventDetailView_mac(event: .constant(Events_mac.sampleData[0]))
}
