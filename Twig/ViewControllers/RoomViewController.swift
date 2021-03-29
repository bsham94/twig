//
//  RoomViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-26.
//

import UIKit
import CoreData

class RoomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    private var room:Room?
    private let plantIdentifier = "PlantIdentifier" // Collection items
    private let detailsIdentifier = "PlantDetailIdentifier" // Plant segue
    private let context = AppDelegate.viewContext
    private var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    var examplePlants: [Plant] = [Plant]() // TODO: remove hardcoding

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change back button label for next view
        let backButton = UIBarButtonItem()
        //backButton.title = room?.getName() ?? "Room"
        navigationItem.backBarButtonItem = backButton
        
        if (segue.identifier == detailsIdentifier) {
            // Segue to detail view
            let plantViewController = segue.destination as! PlantViewController
            plantViewController.initWithPlant(sender as! Plant)
        }
    } // prepareForSegue
    
    
    func initializeFetchedResults(){
        
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        let fetchSort = NSSortDescriptor(key:"name", ascending: true)
        request.sortDescriptors = [fetchSort]
        
        fetchedResultsController = (NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<NSFetchRequestResult>)
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        }
        catch {

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var plant = Plant(context: context).getName(name: "Jade Plant")
        examplePlants.append(plant)
        plant = plant.getName(name: "Aloe Vera")
        examplePlants.append(plant)
        plant.save(context: context)
        // Setup view
        //self.title = room?.getName() ?? "Undefined"
        // TODO: Remove hardcoded plants
    } // viewDidLoad
    
    // MARK: Mutators
    func initWithRoom(_ room:Room){
        self.room = room
    } // initWithRoom
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return examplePlants.count
    } // numberofItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(
            // Cells are 40% of the screen width
            width: (self.view.frame.size.width * 0.40),
            // Height will be ignored at runtime
            // Due to constraints
            height: 1
        )
        return cellSize
    } // collectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: plantIdentifier, for: indexPath as IndexPath) as! PlantCollectionViewCell
        
        cell.titleLabel.text = examplePlants[indexPath.row].getName(name: examplePlants[indexPath.row].name!).name
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let plant = examplePlants[indexPath.row]
        performSegue(withIdentifier: detailsIdentifier, sender: plant)
    } // didSelectItemAt

}
