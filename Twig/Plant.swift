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
    
    func getRoom(_ name: String) -> Room? {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let rooms = try? context.fetch(request)
        if (rooms?.isEmpty)! {
            return nil // should probably guard for this
            // Maybe create the room if it doesn't already exist?
        }else{
            return rooms![0] as Room
        }
    }
    
    // MARK: Mutators
    func set(name: String, room: String){
        self.name = name
        self.belongs_to = getRoom(room)!
    } // set
    
    class func create(name:String, room:String) {
        let context = AppDelegate.viewContext
        if !Plant.existsWithName(name) {
            print("Adding new plant: \(name) to room: \(room)")
            let plant = Plant(context: context)
            plant.set(name: name, room: room)
        }
    } // create
    
    class func delete(_ name:String) {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        // For now, get all plants with that name and delete them
        // TODO: Get specific plant for room
        // Currently causes an exception to be thrown because it is unsure which
        // plants should be deleted
        if let plants = try? context.fetch(request) {
            for plant in plants {
                print("Deleting plant \(plant.name!)")
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
