//
//  AddPlantViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-04-12.
//

import UIKit

class AddPlantViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    private var destinationRoom: String?
    private var imageWasSelected = false
    let imagePickerController = UIImagePickerController()
    
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
        let destination = destinationTextField.text ?? ""
        if !Room.existsWithName(destination) {
            Alert.errorAlert(self, message: "No room exists with name \(destination)")
            return
        }
        
        // Get all the values
        let name = nameTextField.text ?? ""
        let heat = Int(heatSlider.value * 10)
        let water = Int(waterSlider.value * 10)
        let sun = Int(sunSlider.value * 10)
        let description = aboutTextView.text ?? ""
        let image = imageView.image!
        
        // Create plant
        Plant.create(name: name, room: destination, heat: heat, water: water, sun_light: sun, plant_description: description, imageData: image.pngData()!)
        Alert.addedPlantAlert(self, plantName: name, roomName: destination)
    } // saveButtonTouched
    
    @IBAction func addImageButtonTouched(_ sender: Any) {
        // Use photo library
        imagePickerController.sourceType = .photoLibrary
        
        // Show image picker
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
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
        
        saveButton.isEnabled = (!name.isEmpty && !destination.isEmpty && imageWasSelected)
    }
    
    // MARK: ImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss image picker if user cancelled
        dismiss(animated: true, completion: nil)
        
        // Enable save button only if image was selected
        updateSaveButtonState()
    } // imagePickerControllerDidCancel
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get the selected image
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected dictionary containing an image but got \(info).")
        }
        
        // Set imageview to selected image
        imageView.image = selectedImage
        imageWasSelected = true
        
        // Dismiss image picker
        dismiss(animated: true, completion: nil)
        
        // Enable save button only if image was selected
        updateSaveButtonState()
    } // imagePickerController

}
