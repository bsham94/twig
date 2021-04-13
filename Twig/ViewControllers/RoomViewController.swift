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
    private var room:String?
    private let plantIdentifier = "PlantIdentifier" // Collection items
    private let footerIdentifier = "PlantFooterIdentifier" //  Collection footer
    private let detailsIdentifier = "PlantDetailIdentifier" // Plant segue
    private let addPlantIdentifier = "AddPlantSegueIdentifier"
    private let context = AppDelegate.viewContext
    private var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change back button label for next view
        let backButton = UIBarButtonItem()
        backButton.title = room!
        navigationItem.backBarButtonItem = backButton
        
        if (segue.identifier == detailsIdentifier) {
            // Segue to detail view
            let plantViewController = segue.destination as! PlantViewController
            plantViewController.initWithPlantNamed((sender as! Plant).name ?? "Undefined")
        } else if (segue.identifier == addPlantIdentifier) {
            // Segue to add plant view
            let navController = segue.destination as! UINavigationController
            let addPlantViewController = navController.topViewController as! AddPlantViewController
            addPlantViewController.initWithDestination(room: room!)
        }
    } // prepareForSegue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        self.title = room!
        
        // Load database
        initializeFetchedResultsController()
    } // viewDidLoad
    
    // MARK: Mutators
    func initWithRoomNamed(_ name:String){
        self.room = name
    } // initWithRoomNamed
    
    @IBAction func deleteRoom(_ sender: Any) {
        Alert.deleteRoomAndAlert(self, roomName: room!)
    } // deleteRoom
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    } // numberofItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGSize(
            width: (self.collectionView.frame.width),
            height: 127
        )
        if collectionView.numberOfItems(inSection: 0) > 1 {
            cellSize = CGSize(
                // Cells are 40% of the screen width
                width: (self.collectionView.frame.width * 0.45),
                height: 127 // Height of cell defined in storyboard
            )
        }
        return cellSize
    } // collectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Use custom footer for collectionView
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! AddPlantCollectionReusableView
        return footer
    } // viewForSupplementaryElementOfKind
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: plantIdentifier, for: indexPath as IndexPath) as! PlantCollectionViewCell
        
        let plant = fetchedResultsController.object(at: indexPath) as! Plant
        cell.titleLabel.text = plant.name
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let plant = fetchedResultsController.object(at: indexPath) as! Plant
        performSegue(withIdentifier: detailsIdentifier, sender: plant)
    } // didSelectItemAt
    
    // MARK: NSFetchedResultsController Functions
    func initializeFetchedResultsController() {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        request.predicate = NSPredicate(format: "belongs_to.name = %@", room!)
        let fetchSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [fetchSort]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil) as? NSFetchedResultsController<NSFetchRequestResult>
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    } // initializeFetchedResultsController
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            collectionView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
        case .delete:
            collectionView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
        case .update:
            collectionView.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
        default: break
        }
    } // didChangeSection
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            collectionView.deleteItems(at: [indexPath!])
        case .update:
            collectionView.reloadItems(at: [newIndexPath!])
        default: break
        }
    } // didChangeanObject
}
