//
//  CDEvent_mac+CoreDataProperties.swift
//  calendar_mac
//
//  Created by Greta Zu on 2024-08-14.
//
//

import Foundation
import CoreData


extension CDEvent_mac {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEvent_mac> {
        return NSFetchRequest<CDEvent_mac>(entityName: "CDEvent_mac")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var note: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var createdTime: Date?

}

extension CDEvent_mac : Identifiable {

}
