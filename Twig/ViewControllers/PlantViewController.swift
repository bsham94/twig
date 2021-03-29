//
//  PlantViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit

class PlantViewController: UIViewController {
    
    // MARK: Properties
    private var plant:Plant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        //self.title = plant?.getName() ?? "Undefined"
    }
    

    // MARK: Mutators
    func initWithPlant(_ plant:Plant){
        self.plant = plant
    } // initWithRoom

}
