//
//  PlantViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit

class PlantViewController: UIViewController {
    
    // MARK: Properties
    private var plantName:String?
    
    // MARK: Outlets
    @IBOutlet weak var notificationLabel: UITextView!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var quickAddButton: UIBarButtonItem!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var sunlightTextView: UITextView!
    @IBOutlet weak var waterTextView: UITextView!
    @IBOutlet weak var heatTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.title = plantName
        let plant = Plant.getPlant(plantName!)
        waterTextView.text = mapRequirementsToText(requirement: "water", value: Int(plant?.water ?? 5))
        sunlightTextView.text = mapRequirementsToText(requirement: "sunlight", value: Int(plant?.sun_light ?? 5))
        heatTextView.text = mapRequirementsToText(requirement: "warmth", value: Int(plant?.heat ?? 5))
        aboutTextView.text = plant?.plant_description
        //imageView.image = UIImage(data: (plant?.imageData)!)
        
        // Setup quick add button to be a dropdown
        quickAddButton.menu = UIMenu(title: "", children: quickAddMenuActions())
        
        // Setup notification label
        notificationLabel.layer.borderColor = UIColor.systemYellow.cgColor
        notificationLabel.layer.borderWidth = 2
        notificationLabel.text = "Happy and Healthy."
        
        // Setup water button
        waterButton.layer.cornerRadius = 5.0

    } // viewDidLoad
    
    private func quickAddMenuActions() -> [UIAction] {
        return [
            // Add plant menu action
            UIAction(title: "Add Another", image: UIImage(systemName: "plus"), identifier: nil, discoverabilityTitle: nil, attributes: .init(), state: .off, handler: { _ in })
        ]
    } // quickAddMenuActions
    
    @IBAction func deletePlant(_ sender: Any) {
        Alert.deletePlantAndAlert(self, plantName: plantName!)
    } // deletePlant
    
    // MARK: Mutators
    func initWithPlantNamed(_ name:String){
        self.plantName = name
    } // initWithPlantNamed
    
    func mapRequirementsToText(requirement: String, value: Int) -> String {
        if (value <= 0) {
            return "Almost no \(requirement) required."
        } else if (value > 0 && value < 5) {
            return "Very little \(requirement) required."
        } else if (value == 5) {
            return "Moderate \(requirement) required."
        } else if (value > 5 && value < 10) {
            return "Lots of \(requirement) required."
        } else {
            return "Tons of \(requirement) required."
        }
    } // mapRequirementsToText

}
