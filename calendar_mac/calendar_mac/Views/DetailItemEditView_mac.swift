//
//  DetailItemEditView_mac.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-09.
//

import SwiftUI

//editing a to do item
struct DetailItemEditView_mac: View {
    @Binding var item: ToDoItem_mac
    
    var body: some View {
        
        Form {
            Section(header: Text("Item info")) {
                TextField("Title", text: $item.title)
                DatePicker("Due Date", selection: dueDateBinding)
                TextField("Notes", text: $item.notes)
            }
        }
    }
    private var dueDateBinding: Binding<Date> {
            Binding<Date>(
                get: { Date(timeIntervalSince1970: item.dueDate) },
                set: { item.dueDate = $0.timeIntervalSince1970 }
            )
        }
}

#Preview{
    DetailItemEditView_mac(item: .constant(ToDoItem_mac.sampleData[0]))
}
