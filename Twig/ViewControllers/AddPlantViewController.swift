//
//  AddPlantViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-04-12.
//

import UIKit

class AddPlantViewController: UIViewController {
    
    // MARK: Properties
    private var destinationRoom: String?
    
    // MARK: Outlets
    @IBOutlet weak var destinationTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup view
        if let room = destinationRoom { // if destination was provided
            // Lock this screen to the destination room
            destinationTextField.text = room
            destinationTextField.isEnabled = false
            // Change colour to make it obvious it is disabled
            destinationTextField.backgroundColor = UIColor.systemGray4
        }
    } // viewDidLoad
    
    // MARK: Navigation
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } // cancelButtonTouched
    
    // MARK: Mutators
    func initWithDestination(room:String){
        self.destinationRoom = room
    } // initWithDestination

}
