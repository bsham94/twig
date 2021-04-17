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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var waterSlider: UISlider!
    @IBOutlet weak var sunSlider: UISlider!
    @IBOutlet weak var heatSlider: UISlider!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
        
        updateSaveButtonState()
    } // viewDidLoad
    
    // MARK: Navigation
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } // cancelButtonTouched
    
    @IBAction func saveButtonTouched(_ sender: Any) {
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        // Dismiss keyboard
        nameTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
        aboutTextView.resignFirstResponder()
    } // screenTapped
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        // Dismiss the keyboard only for these two fields.
        // aboutTextView allows return to be pressed
        nameTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
    } // returnKeyPressed
    
    @IBAction func editingDidBegin(_ sender: Any) {
        // Disable Save button while editing
        saveButton.isEnabled = false
    } // editingDidBegin
    
    @IBAction func editingDidEnd(_ sender: Any) {
        // Enable save button only if fields are filled
        updateSaveButtonState()
    } // editingDidEnd
    
    // MARK: Mutators
    func initWithDestination(room:String){
        self.destinationRoom = room
    } // initWithDestination
    
    private func updateSaveButtonState() {
        // Retrieve data from fields
        let name = nameTextField.text ?? ""
        let destination = destinationTextField.text ?? ""
        
        // Verify that the rating was an integer first
        saveButton.isEnabled = (!name.isEmpty && !destination.isEmpty)
    }

}
