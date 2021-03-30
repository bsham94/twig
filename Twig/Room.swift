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

    // MARK: Mutators
    func set(id: Int16, name: String){
        self.id = id
        self.name = name
    } // set
    
    class func create(id:Int16, name:String) {
        let context = AppDelegate.viewContext
        if !Room.existsWithName(name) {
            print("Adding new room: \(id), \(name)")
            let room = Room(context: context)
            room.set(id: id,name: name)
        }
    } // create
    
    func save(context : NSManagedObjectContext)
    {
        do{
            try context.save()
        }
        catch{
            
        }
    } // save
}
