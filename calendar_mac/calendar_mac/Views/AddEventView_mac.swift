//
//  AddEventView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-13.
//

import SwiftUI

// add an event view (goes to adding event view for details)
struct AddEventView_mac: View {
    @State private var addEvent = Events_mac.emptyEvent
    @Binding var events: [Events_mac]
    @Binding var newEventPresented: Bool
    
    var body: some View {
        NavigationStack {
            AddingEventView_mac(viewModel: $addEvent)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            newEventPresented = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            events.append(addEvent)
                            newEventPresented = false
                        }
                    }
                }
                .padding(.leading)
                .padding(.trailing)
        }
    }
}

#Preview {
    AddEventView_mac(events: .constant(Events_mac.sampleData), newEventPresented: .constant(true))
}
