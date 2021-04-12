//
//  Alert.swift
//  Twig
//
//  Created by Zach Merrill on 2021-04-12.
//

import Foundation
import UIKit

class Alert {
    class func addRoomAlert(controller: UIViewController){
        let alertTitle = "Add Room"
        let alertMessage = "Room name:"
        let textFieldText = "Bedroom"
        let addButtonTitle = "Add"
        let cancelButtonTitle = "Cancel"
        
        // Creates a simple alert to add a room
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (nameTextField) -> Void in
            nameTextField.text = textFieldText
        })
        alert.addAction(UIAlertAction(title: addButtonTitle, style: .default, handler: { [weak alert] (action) -> Void in
            let nameTextField = (alert?.textFields![0])! as UITextField
            if !(Room.create(name: nameTextField.text!)) {
                Alert.errorAlert(
                    controller,
                    message: "Room already exists with the name '\(nameTextField.text!)'"
                )
            }
        }))
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    } // addRoomAlert
    
    class func errorAlert(_ controller: UIViewController, message: String) {
        let alertTitle = "An error occurred."
        let submitButtonTitle = "OK"
        
        // Creates a simple error notification
        let alert = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: submitButtonTitle,
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        controller.present(alert,animated: true,completion: nil)
    } // errorAlert
    
}
