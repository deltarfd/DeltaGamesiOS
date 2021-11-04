//
//  CoreDataManager.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 06/10/21.
//

import CoreData

class CoreDataManager: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    static let shared = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "GamesModel")
        persistentContainer.loadPersistentStores {(_, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
