//
//  EventDetailView.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-02.
//

import SwiftUI

// editing event detailed view (+delete an event)
struct EventDetailView: View {
    @Binding var event: Events
    var deleteAction: (() -> Void)? 
    @State private var editingEvent = Events.emptyEvent
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
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    isPresentingEditView = true
                    editingEvent = event
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationView {
                DetailEventEditView(event: $editingEvent)
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

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EventDetailView(event: .constant(Events.sampleData[0]))
        }
    }
}
