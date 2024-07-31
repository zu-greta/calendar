//
//  ScheduleView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-30.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        //TODO: time for events + place in chronological order
        //TODO: click open for details
        
        VStack(spacing: 15){
            Text("Schedule")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            if let event = events.first(where: {event in return isSameDay(date1: event.eventDate, date2: currentDate)}) {
                ForEach(event.event){
                    event in
                    VStack(alignment: .leading, spacing: 10){
                        Text(event.time
                            .addingTimeInterval(CGFloat
                                .random(in: 0...5000)), style: .time)
                        
                        Text(event.title)
                            .font(.title2.bold())
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color(.lavender))
                        .cornerRadius(30)
                        .padding(.horizontal)
                }
            } else {
                Text("No Event Found")
                    .padding([.top, .leading])
            }
        }
        
    }
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1 {
                if let event = events.first(where: {event in
                    return isSameDay(date1: event.eventDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: event.eventDate, date2: currentDate) ? .accentColor : .primary).frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: event.eventDate, date2: currentDate) ? .white : .indigo)
                        .frame(width: 7, height: 7)
                }else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .accentColor : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height:50, alignment: .top)
    }
    
    func isSameDay(date1: Date, date2:Date)->Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func extraDate()->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    func getCurrentMonth()->Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    func extractDate()->[DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap {date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
            
        }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day:-1, date: Date()), at: 0)
        }
        return days
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(currentDate: .constant(Date()))
    }
}


