//
//  CoreDataManager.swift
//  toDoApp_toBuild
//
//  Created by Rania Arbash on 2020-11-24.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    
    func deleteToDo(todoToDelete : ToDo)  {
        
        persistentContainer.viewContext.delete(todoToDelete)
        saveContext()
        
    }
    
    func insertNewToDo(task : String) {
        
        let newToDO = ToDo(context: persistentContainer.viewContext)
        newToDO.task = task
        newToDO.date = Date()
        
        saveContext()
        
    }
    
    
    func search(text : String) -> [ToDo] {
        
        let fetch : NSFetchRequest =  ToDo.fetchRequest()
            let predicate = NSPredicate(format: "task BEGINSWITH [c] %@", text)
            // select * from ToDo where task BEGINSWITH
            fetch.predicate = predicate
            var result : [ToDo] = [ToDo]()
                   do{
                       result = try (persistentContainer.viewContext.fetch(fetch) as? [ToDo])!
                   
                   }catch{
                       
                       
                   }
            
            return result
        
        
    }
    func fetchToDosFromCoreData() -> [ToDo]{
        let fetch : NSFetchRequest =  ToDo.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor.init(key: "task", ascending: true)]
        
        
        var result : [ToDo] = [ToDo]()
        do{
            result = try (persistentContainer.viewContext.fetch(fetch) as? [ToDo])!
        
        }catch{
            
            
        }
        
        return result
        
        
    }
    
    
    func updateTask(oldtask : String, updatedTask : String)  {
        
        let fetch : NSFetchRequest =  ToDo.fetchRequest()
        let predicate = NSPredicate(format: "task == %@", oldtask)
        // select * from ToDo where task == "oldtask"
        fetch.predicate = predicate
        var result : [ToDo] = [ToDo]()
               do{
                   result = try (persistentContainer.viewContext.fetch(fetch) as? [ToDo])!
                result[0].task = updatedTask
               saveContext()

               }catch{
                   
                   
               }
        
        
    }
    
    // MARK: - Core Data stack

     lazy var persistentContainer: NSPersistentContainer = {
         /*
          The persistent container for the application. This implementation
          creates and returns a container, having loaded the store for the
          application to it. This property is optional since there are legitimate
          error conditions that could cause the creation of the store to fail.
         */
         let container = NSPersistentContainer(name: "toDoApp_toBuild")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                  
                 /*
                  Typical reasons for an error here include:
                  * The parent directory does not exist, cannot be created, or disallows writing.
                  * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                  * The device is out of space.
                  * The store could not be migrated to the current model version.
                  Check the error message to determine what the actual problem was.
                  */
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()

     // MARK: - Core Data Saving support

     func saveContext () {
         let context = persistentContainer.viewContext
         if context.hasChanges {
             do {
                 try context.save()
             } catch {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
             }
         }
     }

}

