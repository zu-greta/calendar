//
//  ToDoListView.swift
//  calendar
//
//  Created by Greta Zu on 2024-07-29.
//

import SwiftUI

//TODO: keep the reminder going until checked off
//TODO: highlight in red if 'past due'
//TODO: swipe to delete
//TODO: tap to see detail view and edit view

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
                ForEach(filteredItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title2)
                            HStack {
                                Text("Due:")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        Button(action: {
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                items[index].isDone.toggle()
                            }
                        }) {
                            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.seafoam))
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
                //TODO: fix swipeaction
                .swipeActions{
                    Button(action: {}, label: {
                        Text("delete")
                            .background(Color.red)
                    })}
            }
            
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(items: .constant(ToDoItem.sampleData), currentDate: .constant(Date()))
    }
}


