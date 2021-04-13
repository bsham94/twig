//
//  HomeViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    // MARK: Properties
    private let roomIdentifier = "RoomIdentifier" // Collection items
    private let footerIdentifier = "FooterIdentifier" // Collection footer
    private let detailsIdentifier = "RoomDetailIdentifier" // Room segue
    private let addPlantIdentifier = "AddPlantSegueIdentifier"
    private let context = AppDelegate.viewContext
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    // MARK: Outlets
    @IBOutlet weak var quickAddButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change back button label for next view
        let backButton = UIBarButtonItem()
        backButton.title = "Home"
        navigationItem.backBarButtonItem = backButton
        
        if (segue.identifier == detailsIdentifier) {
            // Segue to detail view
            let roomViewController = segue.destination as! RoomViewController
            roomViewController.initWithRoomNamed((sender as! Room).name ?? "Undefined")
        }
    } // prepareForSegue
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on this view
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    } // viewWillAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar once we leave this view
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    } // viewWillDisappear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        quickAddButton.showsMenuAsPrimaryAction = true
        
        // Load database
        // Could we make this static?
        initializeFetchedResultsController()
        
        initializeDB()
        
    } // viewDidLoad
    
    private func quickAddMenuActions() -> [UIAction] {
        return [
            // Add plant menu action
            UIAction(title: "Add Plant", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in
                self.performSegue(withIdentifier: self.addPlantIdentifier, sender: nil)
            }),
            UIAction(title: "Add Room", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in
                Alert.addRoomAndAlert(controller: self)
            })
        ]
    } // menuActions
    
    @IBAction func addRoomButtonTouched(_ sender: Any) {
        Alert.addRoomAndAlert(controller: self)
    }
    
    func createAlertAndShow(title: String, message: String, buttonText: String) {
        // Creates an alert and presents it
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: buttonText,
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    } // numberofItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roomIdentifier, for: indexPath as IndexPath) as! RoomCollectionViewCell
        
        let room = fetchedResultsController.object(at: indexPath) as! Room
        cell.titleLabel.text = room.name
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Use custom footer for collectionView
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! AddRoomCollectionReusableView
        return footer
    } // viewForSupplementaryElementOfKind
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(
            // Cells are full width of collectionView
            width: (self.collectionView.frame.width),
            height: 127 // Height of cell defined in storyboard
        )
        return cellSize
    } // collectionViewLayout

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let room = fetchedResultsController.object(at: indexPath) as! Room
        performSegue(withIdentifier: detailsIdentifier, sender: room)
    } // didSelectItemAt
    
    // MARK: NSFetchedResultsController Functions
    func initializeFetchedResultsController() {
        let request : NSFetchRequest<Room> = Room.fetchRequest()
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
    
    // MARK: Database
    func initializeDB(){
        // TODO: Remove hardcoded rooms
        Room.create(name: "Bedroom")
        Plant.create(name: "Aloe Vera", room: "Bedroom")
        Plant.create(name: "Sunflower", room: "Bedroom")
        
        Room.create(name: "Living Room")
        Plant.create(name: "Jade Plant", room: "Living Room")
    }
}
