//
//  AppDelegate.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var persistentContainer : NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    static var viewContext : NSManagedObjectContext{
        return persistentContainer.viewContext
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Checks if the hasUserLoggedInBefore UserDefault has been set
        let notFirstLoad = UserDefaults.standard.bool(forKey: "hasUserLoggedInBefore")
        //If it hasnt been set, this is the first time opening the app
        if notFirstLoad == false{
            //Load plants
            initializeDB()
            //Set user default to indicate the app has been opened before
            UserDefaults.standard.set(true, forKey:"hasUserLoggedInBefore")
            print("First Time Launching App")
        }
        else {
            print("Launching App")
        }
        
        return true
    }
    // MARK: Database
    func initializeDB(){
        // TODO: Remove hardcoded rooms
        let image = UIImage(systemName: "questionmark.circle.fill")!
        _ = Room.create(name: "Bedroom")
        Plant.create(name: "Aloe Vera", room: "Bedroom", heat: 10, water: 5, sun_light: 7,plant_description: "Green", imageData: image.pngData()!)
        Plant.create(name: "Sunflower", room: "Bedroom", heat: 9, water: 3, sun_light: 2, plant_description: "Definitely not green", imageData: image.pngData()!)
        Plant.setWaterDateToToday("Sunflower")
        
        _ = Room.create(name: "Living Room")
        Plant.create(name: "Jade Plant", room: "Living Room", heat: 4, water: 6, sun_light: 8, plant_description: "Might be green", imageData: image.pngData()!)
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    func applicationWillTerminate(_ application: UIApplication) {
            self.saveContext()
    }}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Twig")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

