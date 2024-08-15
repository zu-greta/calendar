//
//  MyDatePicker.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-28.
//


import SwiftUI


// month calendar view
struct MyDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    @Binding var events: [Events]
    @Binding var items: [ToDoItem]
    
    var body: some View {
        VStack(spacing: 10) {
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
                            .fill(isToday(date: value.date) ? Color.blue.opacity(0.5) : Color.bubblegum.opacity(0.5))
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
    func CardView(value: DateValue)->some View {
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
                    
                    if hasTodo(for: value.date) {
                        Circle()
                            .fill(isSameDay(date1: value.date, date2: currentDate) ? .gray : .teal)
                            .frame(width: 7, height: 7)
                    }
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 50, alignment: .top)
    }
    
    func hasTodo(for date: Date) -> Bool {
        return items.contains { item in
            return isSameDay(date1: Date(timeIntervalSince1970: item.dueDate), date2: date)
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
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(items: .constant(ToDoItem.sampleData), events: .constant(Events.sampleData), saveAction: {})
    }
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


