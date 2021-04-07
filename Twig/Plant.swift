//
//  Plant.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit
import CoreData

class Plant : NSManagedObject {
    // MARK: Accessors
    class func existsWithName(_ name:String) -> Bool {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            return false
        } else {
            return true
        }
    } // existsWithName
    
    // MARK: Mutators
    func set(id: Int16, name: String){
        self.id = id
        self.name = name
    } // set
    
    class func create(id:Int16, name:String) {
        let context = AppDelegate.viewContext
        if !Plant.existsWithName(name) {
            print("Adding new plant: \(id), \(name)")
            let plant = Plant(context: context)
            plant.set(id: id,name: name)
        }
    } // create
    
    class func delete(name:String) {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        // For now, get all plants with that name and delete them
        // TODO: Get specific plant for room
        // Currently causes an exception to be thrown because it is unsure which
        // plants should be deleted
        if let plants = try? context.fetch(request) {
            for plant in plants {
                context.delete(plant)
            }
        }
    } // delete
    
    func save(context : NSManagedObjectContext)
    {
        do{
            try context.save()
        }
        catch{
            
        }
    } // save
}
