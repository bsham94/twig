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
        imageView.image = UIImage(data: (plant?.imageData)!)
        
        
        // Setup notification label
        notificationLabel.layer.borderColor = UIColor.systemYellow.cgColor
        notificationLabel.layer.borderWidth = 2
        // If we need to water today, alert us
        notificationLabel.text = getWaterNotification(waterDate: (plant?.water_date)!)
        
        // Setup water button
        waterButton.layer.cornerRadius = 5.0

    } // viewDidLoad
    
    @IBAction func deletePlant(_ sender: Any) {
        Alert.deletePlantAndAlert(self, plantName: plantName!)
    } // deletePlant
    
    @IBAction func waterButtonTouched(_ sender: Any) {
        Plant.water(plantName!)
        let plant = Plant.getPlant(plantName!)
        notificationLabel.text = getWaterNotification(waterDate: (plant?.water_date)!)
    }
    
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
    
    func getWaterNotification(waterDate: Date) -> String {
        let currentDate = Date()
        print(waterDate)
        if(Calendar.current.isDate(waterDate, inSameDayAs: currentDate)) {
            return "Watering day! Please consider watering \(plantName ?? "Undefined") today!"
        } else if (currentDate > waterDate){
            return "It's past watering day! Water ASAP!"
        } else {
            let components = Calendar.current.dateComponents([.day, .month], from: waterDate)
            return "Happy and Healthy. \nNext watering day: \(components.month!)/\(components.day!)"
        }
    } // getWaterNotification

}
