//
//  Room.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit
import CoreData

class Room : NSManagedObject {
    // MARK: Properties
    //private let name: String
    
    // MARK: Constructor
//    init(_ name: String) {
//        self.name = name
//    }
    class func makeRoom(id:Int16, name:String) {
        let context = AppDelegate.viewContext
        if !Room.roomExists(name: name) {
            print("---Class Room--adding new room------")
            let room = Room(context: context)
            room.set(id: id,name: name)
        }
    } // makeMovies
    
    class func roomExists(name:String) -> Bool {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", name)
        let context = AppDelegate.viewContext
        let rooms = try? context.fetch(request)
        if (rooms?.isEmpty)! {
            return false
        } else {
            return true
        }
    }

    func set(id: Int16, name: String){
        self.id = id
        self.name = name
    }
    
    func save(context : NSManagedObjectContext)
    {
        do{
            try context.save()
        }
        catch{
            
        }
    }
    
    // MARK: Accessors
    func getName(name: String) -> Room {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        // direct way to get the context
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context: NSManagedObjectContext = container.viewContext
        
        let rooms = try? context.fetch(request)
        if (rooms?.isEmpty)! {
            let newRoom = Room(context: context)
            newRoom.name = name
            print("Added New Room  \(name)")
            return newRoom
        } else {
            return rooms![0] as Room
        }
    }

    // MARK: Mutators
    // TODO
}
