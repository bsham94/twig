//
//  HomeViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: Properties
    private let reuseIdentifier = "ReuseIdentifier"
    
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RoomCollectionViewCell
        
        cell.titleLabel.text = "Add Room"
        return cell
    }

}
