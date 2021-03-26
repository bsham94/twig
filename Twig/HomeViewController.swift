//
//  HomeViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    private let roomIdentifier = "RoomIdentifier"
    private let footerIdentifier = "FooterIdentifier"
    let exampleRooms = [
        "Bedroom",
        "Living Room"
    ]
    
    // MARK: Outlets
    @IBOutlet weak var quickAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        quickAddButton.showsMenuAsPrimaryAction = true
        
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
        
        cell.titleLabel.text = exampleRooms[indexPath.row]
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Use custom footer for collectionView
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! AddRoomCollectionReusableView
        return footer
    } // viewForSupplementaryElementOfKind
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(
            // Cells are 83% of the screen width to align
            // with the footer button below them
            width: (self.view.frame.size.width * 0.83),
            // Height will be ignored at runtime
            height: 1
        )
        return cellSize
    }
    

}
