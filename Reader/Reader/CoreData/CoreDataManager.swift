//
//  CoreDataManager.swift
//  Reader
//
//  Created by Dipesh Patel on 18/09/25.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "NewsDB")
        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint("Failed to load store\(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
}
