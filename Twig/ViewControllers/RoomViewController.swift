//
//  RoomViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-26.
//

import UIKit

class RoomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    private var room:Room?
    private let plantIdentifier = "PlantIdentifier" // Collection items
    private let detailsIdentifier = "PlantDetailIdentifier" // Plant segue
    
    var examplePlants: [Plant] = [Plant]() // TODO: remove hardcoding

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change back button label for next view
        let backButton = UIBarButtonItem()
        backButton.title = room?.getName() ?? "Room"
        navigationItem.backBarButtonItem = backButton
        
        if (segue.identifier == detailsIdentifier) {
            // Segue to detail view
            let plantViewController = segue.destination as! PlantViewController
            plantViewController.initWithPlant(sender as! Plant)
        }
    } // prepareForSegue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        self.title = room?.getName() ?? "Undefined"
        
        // TODO: Remove hardcoded plants
        examplePlants.append(Plant("Jade Plant"))
        examplePlants.append(Plant("Aloe Vera"))
        print("hello")
        
    } // viewDidLoad
    
    // MARK: Mutators
    func initWithRoom(_ room:Room){
        self.room = room
    } // initWithRoom
    
    // MARK: UICollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return examplePlants.count
    } // numberofItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(
            // Cells are 40% of the screen width
            width: (self.view.frame.size.width * 0.40),
            // Height will be ignored at runtime
            // Due to constraints
            height: 1
        )
        return cellSize
    } // collectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: plantIdentifier, for: indexPath as IndexPath) as! PlantCollectionViewCell
        
        cell.titleLabel.text = examplePlants[indexPath.row].getName()
        return cell
    } // cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let plant = examplePlants[indexPath.row]
        performSegue(withIdentifier: detailsIdentifier, sender: plant)
    } // didSelectItemAt

}
