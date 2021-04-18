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
    
    class func getAllPlants() -> [Plant]? {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        //request.predicate = NSPredicate(format: "name = %@", name)
        //let plantRequest = NSFetchRequest<Plant>(entityName: "Plant")
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            return nil
        } else {
            return plants! as [Plant]
        }
    }
    
    
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
    
    class func getPlant(_ name: String) -> Plant? {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            return nil // should probably guard for this
            // Maybe create the room if it doesn't already exist?
        }else{
            return plants![0] as Plant
        }
    } // getPlant
    
    class func getTimeInterval(waterAmount: Int) -> TimeInterval {
        let daysToSeconds = 24*60*60
        var time = 0
        if (waterAmount <= 0) {
            time = 30 * daysToSeconds // 30 days
        } else if (waterAmount > 0 && waterAmount < 5) {
            time = 14 * daysToSeconds // 14 days
        } else if (waterAmount == 5) {
            time = 7 * daysToSeconds // 7 days
        } else if (waterAmount > 5 && waterAmount < 10) {
            time = 4 * daysToSeconds // 4 days
        } else {
            time = 2 * daysToSeconds // 2 days
        }
        return TimeInterval(time)
    } // getTimeInterval
    
    // MARK: Mutators
    func set(name: String, room: String,heat: Int, water: Int, sun_light: Int, plant_description: String, imageData: Data){
        self.name = name
        self.belongs_to = getRoom(room)!
        self.heat = Int16(heat)
        self.water = Int16(water)
        self.sun_light = Int16(sun_light)
        self.plant_description = plant_description
        self.imageData = imageData
        self.water_date = Date().addingTimeInterval(Plant.getTimeInterval(waterAmount: water))
    } // set
    
    class func create(name:String, room:String, heat: Int, water: Int, sun_light: Int, plant_description: String, imageData: Data) {
        let context = AppDelegate.viewContext
        if !Plant.existsWithName(name) {
            print("Adding new plant: \(name) to room: \(room)")
            let plant = Plant(context: context)
            plant.set(name: name, room: room, heat: heat, water: water, sun_light: sun_light, plant_description: plant_description, imageData: imageData)
        }
    } // create
    
    class func water(_ name: String) {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            return
        }else{
            let plant = plants![0] as Plant
            let interval = Plant.getTimeInterval(waterAmount: Int(plant.water))
            let newDate = Date().addingTimeInterval(interval)
            print("Setting new water date \(newDate)")
            plant.setValue(newDate, forKey: "water_date")
            return
        }
    } // water
    
    class func setWaterDateToToday(_ name: String) {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        let context = AppDelegate.viewContext
        let plants = try? context.fetch(request)
        if (plants?.isEmpty)! {
            return
        }else{
            let plant = plants![0] as Plant
            let newDate = Date()
            plant.setValue(newDate, forKey: "water_date")
            return
        }
    } // setWaterDateToToday
    
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
