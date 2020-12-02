//
//  todoTableViewController.swift
//  toDoApp_toBuild
//
//  Created by Rania Arbash on 2020-11-24.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit
import CoreData

class todoTableViewController: UITableViewController {

   // var allToDos = [ToDo]()
    lazy var myFetchResultsController :
        
        NSFetchedResultsController<ToDo> = {
          //fetch
           let fetch : NSFetchRequest<ToDo> = ToDo.fetchRequest()
           fetch.sortDescriptors = [NSSortDescriptor(key: "task", ascending: false)]
//
//            let fetchRcontroller = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: "date", cacheName: nil)
//

        let fetchRcontroller =
        NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: "task", cacheName: nil)

        return fetchRcontroller
           
           //fetchcontroller
           
       }()
      
    func getDate(currentDate : Date) -> String{
        
     let formatter = DateFormatter()
         formatter.timeStyle = .medium
     formatter.dateStyle = .full
         
         let dateTimeString = formatter.string(from: currentDate)
     return dateTimeString
     }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchAllToDos()
        try? myFetchResultsController.performFetch()
        tableView.reloadData()
       
    }

    func fetchAllToDos()  {
        //allToDos = CoreDataManager.shared.fetchToDosFromCoreData()
        try? myFetchResultsController.performFetch()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    @IBAction func AddNewTask(_ sender: Any) {
        let alert = UIAlertController.init(title: "Add New Task", message: "", preferredStyle: .alert)
               var textField = UITextField()
               
               alert.addTextField { (alertTextField) in
                   alertTextField.placeholder = "Enter A new Task"
                   textField = alertTextField
               }
               
               let action = UIAlertAction.init(title: "Save", style: .default) { (action) in
                   if let correctTask = textField.text {
                    CoreDataManager.shared.insertNewToDo(task: correctTask)
                    self.fetchAllToDos()
                   }
                   }
               let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
                   self.dismiss(animated: true, completion: nil)
                   }
                   
               
               alert.addAction(action)
               alert.addAction(cancelAction)
               present(alert, animated: true, completion: nil)
               
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
              let alert = UIAlertController.init(title: "Update Task", message: "", preferredStyle: .alert)
              var textField = UITextField()
            var oldTask : String = String()
              alert.addTextField { (alertTextField) in
                  alertTextField.text = self.myFetchResultsController.object(at: indexPath).task
                oldTask = self.myFetchResultsController.object(at: indexPath).task!
                textField = alertTextField
              }
              
              let action = UIAlertAction.init(title: "Update", style: .default) { (action) in
                  if let correctTask = textField.text {
                    
                    CoreDataManager.shared.updateTask(oldtask:oldTask , updatedTask: correctTask)
                    
                    self.fetchAllToDos()

                }
              }
              let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
                  self.dismiss(animated: true, completion: nil)
              }
              
              
              alert.addAction(action)
              alert.addAction(cancelAction)
              present(alert, animated: true, completion: nil)
              
             
               
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return myFetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return myFetchResultsController.sections?[section].numberOfObjects ?? 0
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return
            myFetchResultsController.sections?[section].indexTitle ?? ""
      }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

      //  cell.textLabel?.text = allToDos[indexPath.row].task

        cell.textLabel?.text = myFetchResultsController.object(at: indexPath).task
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            CoreDataManager.shared.deleteToDo(todoToDelete: myFetchResultsController.object(at: indexPath))
            fetchAllToDos()
            
        }
    }
    

}

extension todoTableViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == ""){
            fetchAllToDos()
        }
        else {
        //allToDos = CoreDataManager.shared.search(text: searchText)
         tableView.reloadData()
        }
    }
    
}
