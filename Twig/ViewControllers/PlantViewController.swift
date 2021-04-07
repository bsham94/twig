//
//  PlantViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit

class PlantViewController: UIViewController {
    
    // MARK: Properties
    private var plant:String?
    
    // MARK: Outlets
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var notificationLabel: UITextView!
    @IBOutlet weak var quickAddButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.title = plant
        
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        quickAddButton.showsMenuAsPrimaryAction = true
        
        // Setup notification label
        notificationLabel.isHidden = true // Hide until it's almost watering day
        
        // Setup water button
        waterButton.isHidden = true // Hide until it's almost watering day
        waterButton.layer.cornerRadius = 5.0

    }
    
    private func quickAddMenuActions() -> [UIAction] {
        return [
            // Add plant menu action
            UIAction(title: "Add Another", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in })
        ]
    } // quickAddMenuActions
    
    @IBAction func deletePlant(_ sender: Any) {
        Plant.delete(name: plant!)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Mutators
    func initWithPlantNamed(_ name:String){
        self.plant = name
    } // initWithPlantNamed

}
