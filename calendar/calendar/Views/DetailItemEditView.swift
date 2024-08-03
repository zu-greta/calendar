//
//  DetailItemEditView.swift
//  calendar
//
//  Created by Greta Zu on 2024-08-02.
//

import SwiftUI

//editing a to do item
struct DetailItemEditView: View {
    @Binding var item: ToDoItem
    
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

struct DetailItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemEditView(item: .constant(ToDoItem.sampleData[0]))
    }
}
