//
//  File.swift
//  
//
//  Created by Pavel Gnatyuk on 06/03/2020.
//

import Foundation

#if canImport(CoreData)
import CoreData

public extension NSManagedObjectContext {
    func saveContext() {
        if hasChanges {
            do {
                try save()
                
            } catch let error as NSError {
                // Added from a Florian book Core Data. It simply abandons the unsaved data.
                rollback()
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

#endif
