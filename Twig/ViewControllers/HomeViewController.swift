//
//  HomeViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    private let roomIdentifier = "RoomIdentifier" // Collection items
    private let footerIdentifier = "FooterIdentifier" // Collection footer
    private let detailsIdentifier = "RoomDetailIdentifier" // Room segue
    private let context = AppDelegate.viewContext
    var exampleRooms: [Room] = [Room]() // TODO: remove hardcoding
    
    // MARK: Outlets
    @IBOutlet weak var quickAddButton: UIButton!
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change back button label for next view
        let backButton = UIBarButtonItem()
        backButton.title = "Home"
        navigationItem.backBarButtonItem = backButton
        
        if (segue.identifier == detailsIdentifier) {
            // Segue to detail view
            let roomViewController = segue.destination as! RoomViewController
            roomViewController.initWithRoom(sender as! Room)
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
        
        // Hide navigation bar on this view
        // We'll re-enable it in the next view
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        quickAddButton.showsMenuAsPrimaryAction = true
        // TODO: Remove hardcoded rooms
        var room = Room(context: context).getName(name: "Bed Room")
        exampleRooms.append(room)
        room = room.getName(name: "Living Room")
        exampleRooms.append(room)
        room.save(context: context)
        
        
        
    } // viewDidLoad
    
    private func quickAddMenuActions() -> [UIAction] {
        return [
            // Add plant menu action
            UIAction(title: "Add Plant", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in }),
            UIAction(title: "Add Room", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in })
        ]
    } // menuActions
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exampleRooms.count
    } // numberofItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roomIdentifier, for: indexPath as IndexPath) as! RoomCollectionViewCell
        
        cell.titleLabel.text = exampleRooms[indexPath.row].getName(name: exampleRooms[indexPath.row].name!).name
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Use custom footer for collectionView
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! AddRoomCollectionReusableView
        return footer
    } // viewForSupplementaryElementOfKind
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(
            // Cells are 80% of the screen width
            width: (self.view.frame.size.width * 0.80),
            // Height will be ignored at runtime
            height: 1
        )
        return cellSize
    } // collectionViewLayout

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let room = exampleRooms[indexPath.row]
        performSegue(withIdentifier: detailsIdentifier, sender: room)
    } // didSelectItemAt
}
