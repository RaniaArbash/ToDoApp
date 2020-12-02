//
//  ToDo+CoreDataProperties.swift
//  toDoApp_toBuild
//
//  Created by Rania Arbash on 2020-11-24.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var id: Int32
    @NSManaged public var task: String?
    @NSManaged public var date: Date?
    @NSManaged public var implementer: Person?

}
