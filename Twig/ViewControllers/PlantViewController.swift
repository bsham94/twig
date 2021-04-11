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
    @IBOutlet weak var notificationLabel: UITextView!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var quickAddButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.title = plant
        
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        
        // Setup notification label
        notificationLabel.layer.borderColor = UIColor.systemYellow.cgColor
        notificationLabel.layer.borderWidth = 2
        notificationLabel.text = "Happy and Healthy."
        
        // Setup water button
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
