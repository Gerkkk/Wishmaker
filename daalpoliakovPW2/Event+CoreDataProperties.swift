//
//  Event+CoreDataProperties.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 02.12.2024.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {

}

extension Event {
    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var note: String?
}

extension Event : Identifiable {

}
