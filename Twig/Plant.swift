//
//  Plant.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit
import CoreData

class Plant : NSManagedObject {
    // MARK: Properties
//    private let name: String
//
//    // MARK: Constructor
//    init(_ name: String) {
//        self.name = name
//    }
//
//    // MARK: Accessors
    static var myId = 1
    func getName(name: String) -> Plant {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        // direct way to get the context
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context: NSManagedObjectContext = container.viewContext
        
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            let newPlant = Plant(context: context)
            newPlant.name = name
            newPlant.id = Int16(Plant.myId)
            Plant.myId += 1
            print("Added New Plant  \(name)")
            return newPlant
        } else {
            return plants![0] as Plant
        }
    }
    
    class func makePlant(id:Int16, name:String) {
        let context = AppDelegate.viewContext
        if !Plant.plantExists(name: name) {
            print("---Class Room--adding new room------")
            let plant = Plant(context: context)
            plant.set(id: id,name: name)
        }
    } // makeMovies
    
    class func plantExists(name:String) -> Bool {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", name)
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
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
    
    // MARK: Mutators
    // TODO
    
    //MARK: CoreData

}
