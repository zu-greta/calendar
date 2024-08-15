//
//  ToDoListView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-29.
//

import SwiftUI

//TODO: 'past due' items not checked off keep it showing up in following days

// to do list view
struct ToDoListView: View {
    @Binding var items: [ToDoItem]
    @Binding var currentDate: Date

    var body: some View {
        VStack(spacing: 15) {
            Text("To Do List")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            let filteredItems = items.filter { isSameDay(date1: Date(timeIntervalSince1970: $0.dueDate), date2: currentDate) }
            
            if filteredItems.isEmpty {
                Text("No items found")
                    .padding([.top, .leading])
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredItems) { item in
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                NavigationLink(destination: ItemDetailView(item: $items[index], deleteAction: {items.remove(at: index)})) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.title)
                                                .font(.title2)
                                                .foregroundColor(Date(timeIntervalSince1970: item.dueDate) < Date() ? .red : .primary)
                                            HStack {
                                                Text("Due:")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                        Button(action: {
                                            items[index].isDone.toggle()
                                        }) {
                                            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(item.isDone ? Color.gray.opacity(0.3) : Color(.seafoam))
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
}

func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
}
func isDateInRange(date: Date, startDate: Date, endDate: Date) -> Bool {
    return (startDate...endDate).contains(date)
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(items: .constant(ToDoItem.sampleData), currentDate: .constant(Date()))
    }
}
