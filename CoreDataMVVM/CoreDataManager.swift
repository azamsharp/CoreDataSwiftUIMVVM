//
//  CoreDataManager.swift
//  CoreDataMVVM
//
//  Created by Mohammad Azam on 4/19/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task? {
        
        do {
            return try viewContext.existingObject(with: id) as? Task
        } catch {
            return nil
        }
        
    }
    
    func deleteTask(task: Task) {
        
        viewContext.delete(task)
        save()
        
    }
    
    func getAllTasks() -> [Task] {
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TodoAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
