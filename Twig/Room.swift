//
//  Room.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit
import CoreData

class Room : NSManagedObject {
    // MARK: Accessors
    class func existsWithName(_ name:String) -> Bool {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let rooms = try? context.fetch(request)
        if (rooms?.isEmpty)! {
            return false
        } else {
            return true
        }
    } // existsWithName
    
    class func getPlantsInRoom(_ name: String) -> [Plant] {
        if Room.existsWithName(name) {
            let request : NSFetchRequest<Plant> = Plant.fetchRequest()
            request.predicate = NSPredicate(format: "belongs_to.name = %@", name)
            let context = AppDelegate.viewContext
            let plants = try? context.fetch(request)
            if !(plants?.isEmpty)! { // if not empty
                return plants! as [Plant]
            }
        }
        return [Plant]()
    } // getPlantsInRoom

    // MARK: Mutators
    func set(name: String){
        self.name = name
    } // set
    
    class func create(name:String) -> Bool {
        let context = AppDelegate.viewContext
        if !Room.existsWithName(name) {
            print("Adding new room: \(name)")
            let room = Room(context: context)
            room.set(name: name)
            return true
        } else {
            print("Room already exists")
            return false
        }
    } // create
    
    class func delete(_ name:String) {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let rooms = try? context.fetch(request)
        if !(rooms?.isEmpty)! { // if room exists
            let room = rooms![0] as Room
            let plants = Room.getPlantsInRoom(room.name!)
            for plant in plants {
                Plant.delete(plant.name!)
            }
            context.delete(room)
        }
    } // delete
}
