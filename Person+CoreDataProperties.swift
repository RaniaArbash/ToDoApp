//
//  Person+CoreDataProperties.swift
//  toDoApp_toBuild
//
//  Created by Rania Arbash on 2020-11-24.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var all_todos: NSSet?

}

// MARK: Generated accessors for all_todos
extension Person {

    @objc(addAll_todosObject:)
    @NSManaged public func addToAll_todos(_ value: ToDo)

    @objc(removeAll_todosObject:)
    @NSManaged public func removeFromAll_todos(_ value: ToDo)

    @objc(addAll_todos:)
    @NSManaged public func addToAll_todos(_ values: NSSet)

    @objc(removeAll_todos:)
    @NSManaged public func removeFromAll_todos(_ values: NSSet)

}
