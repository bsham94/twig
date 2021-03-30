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
    

    // MARK: Mutators
    func initWithPlantNamed(_ name:String){
        self.plant = name
    } // initWithPlantNamed

}
