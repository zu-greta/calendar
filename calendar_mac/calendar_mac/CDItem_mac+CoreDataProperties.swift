//
//  CDItem_mac+CoreDataProperties.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-14.
//
//

import Foundation
import CoreData


extension CDItem_mac {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDItem_mac> {
        return NSFetchRequest<CDItem_mac>(entityName: "CDItem_mac")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var dueDate: Date?
    @NSManaged public var createdDate: Date?
    @NSManaged public var notes: String?
    @NSManaged public var isDone: Bool

}

extension CDItem_mac : Identifiable {

}
