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
    private let context = AppDelegate.viewContext
    private var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    var examplePlants: [Plant] = [Plant]() // TODO: remove hardcoding

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
        }
    } // prepareForSegue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        self.title = room!
        
        // Load database
        initializeFetchedResultsController()
        
        // TODO: Remove hardcoded plants
        Plant.create(id: 1, name: "Aloe Vera")
        Plant.create(id: 2, name: "Jade Plant")
    } // viewDidLoad
    
    // MARK: Mutators
    func initWithRoomNamed(_ name:String){
        self.room = name
    } // initWithRoomNamed
    
    @IBAction func deleteRoom(_ sender: Any) {
        Room.delete(name: room!)
        self.navigationController?.popViewController(animated: true)
    } // deleteRoom
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            print(sections[section].numberOfObjects)
            return sections[section].numberOfObjects
        } else {
            return 0
        }
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
        default: break
        }
    } // didChangeSection
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            collectionView.deleteItems(at: [indexPath!])
        default: break
        }
    } // didChangeanObject
}
