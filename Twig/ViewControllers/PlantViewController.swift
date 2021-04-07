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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.title = plant
    }
    
    @IBAction func deletePlant(_ sender: Any) {
        Plant.delete(name: plant!)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Mutators
    func initWithPlantNamed(_ name:String){
        self.plant = name
    } // initWithPlantNamed

}
