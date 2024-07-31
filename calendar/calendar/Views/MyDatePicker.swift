//
//  MyDatePicker.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//

import SwiftUI

struct MyDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    //private let colors: [Color] = [.periwinkle, .seafoam]
    
    //TODO: add alarms, todo list view, types of calendars, health trackers (highlights?)
    var body: some View {
        VStack(spacing: 35) {
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                VStack (alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button(action: {withAnimation {currentMonth -= 1}}, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                })
                Button(action: {withAnimation {currentMonth += 1}}, label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                })
            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) {
                    day in Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(extractDate()) {
                    value in CardView(value: value)
                        .background(Capsule()
                            .fill(.lavender)
                        .padding(.horizontal, 8)
                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                    )
                        .onTapGesture{
                            currentDate = value.date
                        }
                }
            }
        }
        .onChange(of: currentMonth) {
            newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    //TODO: database/file for user data instead of sample data
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


struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}

extension Date {
    func getAllDates()->[Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap {
            day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
