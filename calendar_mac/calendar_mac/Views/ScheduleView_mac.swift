//
//  ScheduleView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

struct ScheduleView_mac: View {
    @Binding var events: [Events_mac]
    @Binding var currentDate: Date

    var body: some View {
        VStack(spacing: 15){
            Text("Schedule")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            let filteredEvents = events.filter { isSameDay(date1: Date(timeIntervalSince1970: $0.startTime), date2: currentDate) || isSameDay(date1: Date(timeIntervalSince1970: $0.endTime), date2: currentDate) || isDateInRange(date: currentDate, startDate: Date(timeIntervalSince1970: $0.startTime), endDate: Date(timeIntervalSince1970: $0.endTime))}
                            .sorted { $0.endTime
                                < $1.endTime }
            if filteredEvents.isEmpty {
                Text("No events found")
                    .padding([.top, .leading])
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(events) 
                        { event in
                            if let index = events.firstIndex(where: { $0.id == event.id && (isSameDay(date1: Date(timeIntervalSince1970: $0.startTime), date2: currentDate) || isSameDay(date1: Date(timeIntervalSince1970: $0.endTime), date2: currentDate) || isDateInRange(date: currentDate, startDate: Date(timeIntervalSince1970: $0.startTime), endDate: Date(timeIntervalSince1970: $0.endTime))) }) {
                                NavigationLink(destination: EventDetailView_mac(event: $events[index], deleteAction: {events.remove(at: index)})) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            
                                            Text(event.title)
                                                .font(.title2)
                                                .foregroundColor(Date(timeIntervalSince1970: event.endTime) < Date() ? .gray : .primary)

                                            HStack {
                                                Text("\(Date(timeIntervalSince1970: event.startTime).formatted(date: .abbreviated, time: .shortened))")
                                                    .foregroundColor(Date(timeIntervalSince1970: event.endTime) < Date() ? .gray : .primary)
                                                .font(.footnote)
                                                Spacer()
                                                Text("to")
                                                    .foregroundColor(Date(timeIntervalSince1970: event.endTime) < Date() ? .gray : .primary)
                                                .font(.footnote)
                                                Spacer()
                                                Text("\(Date(timeIntervalSince1970: event.endTime).formatted(date: .abbreviated, time: .shortened))")
                                                    .foregroundColor(Date(timeIntervalSince1970: event.endTime) < Date() ? .gray : .primary)
                                                .font(.footnote)
                                            }
                                             
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.purple).opacity(0.4))
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
    /*
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func isDateInRange(date: Date, startDate: Date, endDate: Date) -> Bool {
        return (startDate...endDate).contains(date)
    }*/
}

#Preview {
    ScheduleView_mac(events: .constant(Events_mac.sampleData), currentDate: .constant(Date()))
}
