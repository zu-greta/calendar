//
//  AddEventView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

struct AddEventView: View {
    @State private var addEvent = Events.emptyEvent
    @Binding var events: [Events]
    @Binding var newEventPresented: Bool
    
    var body: some View {
        NavigationStack {
            AddingEventView(viewModel: $addEvent)
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
            
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(events: .constant(Events.sampleData), newEventPresented: .constant(true))
    }
}


