//
//  ScheduleView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import SwiftUI

//TODO: place in chronological order
//TODO: click open for details and edit view
//TODO: tab instead of dot? for events lasting longer

// schedule view
struct ScheduleView: View {
    @Binding var events: [Events]
    @Binding var currentDate: Date

    var body: some View {
        VStack(spacing: 15){
            Text("Schedule")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            let filteredEvents = events.filter { isSameDay(date1: Date(timeIntervalSince1970: $0.startTime), date2: currentDate) }
            if filteredEvents.isEmpty {
                Text("No events found")
                    .padding([.top, .leading])
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredEvents) { event in
                            if let index = events.firstIndex(where: { $0.id == event.id }) {
                                NavigationLink(destination: EventDetailView(event: $events[index], deleteAction: {events.remove(at: index)})) { //DELETE
                                    HStack {
                                        VStack(alignment: .leading) {
                                            
                                            Text(event.title)
                                                .font(.title2)
                                                .foregroundColor(Date(timeIntervalSince1970: event.endTime) < Date() ? .gray : .primary)

                                            Text("\(Date(timeIntervalSince1970: event.startTime).formatted(date: .abbreviated, time: .shortened))")
                                             
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.lavender))
                                    .cornerRadius(30)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(events: .constant(Events.sampleData), currentDate: .constant(Date()))
    }
}

