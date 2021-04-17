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
    @IBOutlet weak var aboutTextView: UITextView!
    

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
        // Adjust about text view to look like a large text field
        aboutTextView.layer.borderColor = UIColor.systemGray5.cgColor
        aboutTextView.layer.borderWidth = 1.0
        aboutTextView.layer.cornerRadius = 8.0
        aboutTextView.layer.masksToBounds = true
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
