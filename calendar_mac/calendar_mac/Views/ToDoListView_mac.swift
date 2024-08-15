//
//  ToDoListView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

//TODO: 'past due' items not checked off keep it showing up in following days

// to do list view
struct ToDoListView_mac: View {
    @Binding var items: [ToDoItem_mac]
    @Binding var currentDate: Date

    var body: some View {
        NavigationStack { //navigationstack not VIEW
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
                            ForEach(items)
                            { item in
                                if let index = items.firstIndex(where: { $0.id == item.id && isSameDay(date1: Date(timeIntervalSince1970: $0.dueDate), date2: currentDate) }) {
                                    NavigationLink(destination: ItemDetailView_mac(item: $items[index], deleteAction: {items.remove(at: index)})) {
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
                                        .background(item.isDone ? Color.gray.opacity(0.3) : Color(.blue).opacity(0.4))
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
}

func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
}
func isDateInRange(date: Date, startDate: Date, endDate: Date) -> Bool {
    return (startDate...endDate).contains(date)
}

#Preview {
    ToDoListView_mac(items: .constant(ToDoItem_mac.sampleData), currentDate: .constant(Date()))
}
