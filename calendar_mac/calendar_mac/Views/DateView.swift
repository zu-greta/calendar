//
//  DateView.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-06.
//

import SwiftUI

struct DateView: View {
    @State var currentMonth: Int = 0
    @Binding var currentDate: Date
    
    @Binding var events: [Events_mac]
    @Binding var items: [ToDoItem_mac]
    
    var body: some View {
        VStack {
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack (spacing: 20) {
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
                            .fill(isToday(date: value.date) ? Color.blue.opacity(0.5) : Color.pink.opacity(0.5))
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
    @ViewBuilder
    func CardView(value: DateValue_mac)->some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .accentColor : .primary)
                    .frame(maxWidth: .infinity)
                Spacer()
                
                HStack(spacing: 3) {
                    if let event = events.first(where: { event in
                        return isDateInRange(date: value.date, startDate: Date(timeIntervalSince1970: event.startTime), endDate: Date(timeIntervalSince1970: event.endTime)) || isSameDay(date1: dateEvent(from: event.startTime), date2: value.date)
                    }) {
                        Circle()
                            .fill(isSameDay(date1: value.date, date2: currentDate) ? .white : .indigo)
                            .frame(width: 7, height: 7)
                    }
                    
                    if hasToDo(for: value.date) {
                        Circle()
                            .fill(isSameDay(date1: value.date, date2: currentDate) ? .gray : .teal)
                            .frame(width: 7, height: 7)
                    }
                }
            }
        }
        .padding(.vertical, 7)
        .frame(height: 50, alignment: .top)
    }
    
    func hasToDo(for date: Date) -> Bool {
        return items.contains {
            item in return isSameDay(date1: Date(timeIntervalSince1970: item.dueDate), date2: date)
        }
    }
     func isDateInRange(date: Date, startDate: Date, endDate: Date) -> Bool {
         return (startDate...endDate).contains(date)
     }
     
     func isSameDay(date1: Date, date2: Date) -> Bool {
         let calendar = Calendar.current
         return calendar.isDate(date1, inSameDayAs: date2)
     }
     
     func isToday(date: Date) -> Bool {
         let calendar = Calendar.current
         return calendar.isDateInToday(date)
     }
     
     func extraDate() -> [String] {
         let formatter = DateFormatter()
         formatter.dateFormat = "YYYY MMMM"
         let date = formatter.string(from: currentDate)
         return date.components(separatedBy: " ")
     }
     
     func getCurrentMonth() -> Date {
         let calendar = Calendar.current
         guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
             return Date()
         }
         return currentMonth
     }
     
     func extractDate() -> [DateValue_mac] {
         let calendar = Calendar.current
         let currentMonth = getCurrentMonth()
         var days = currentMonth.getAllDates().compactMap { date -> DateValue_mac in
             let day = calendar.component(.day, from: date)
             return DateValue_mac(day: day, date: date)
         }
         let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
         for _ in 0..<firstWeekday - 1 {
             days.insert(DateValue_mac(day: -1, date: Date()), at: 0)
         }
         return days
     }
}


#Preview {
    DateView(currentDate: .constant(Date()),events: .constant(Events_mac.sampleData), items: .constant(ToDoItem_mac.sampleData))
        .frame(width: 400, height: 500)
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
