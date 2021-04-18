//
//  TasksViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit
import CoreData

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let context = AppDelegate.viewContext
    let segueId = "PlantViewSegue"
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewWillAppear(_ animated: Bool) {
        print("VIEW APPEARED")
        initializeFetchedResultsController()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        initializeFetchedResultsController()
    }
    
    // MARK: NSFetchedResultsController Functions
    func initializeFetchedResultsController() {
        let request : NSFetchRequest<Plant> = Plant.fetchRequest()
        let fetchSort = NSSortDescriptor(key: "water_date", ascending: true)
        request.sortDescriptors = [fetchSort]
        let currentDate = Date()
        request.predicate = NSPredicate(format: "water_date <= %@", currentDate as NSDate)

        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil) as? NSFetchedResultsController<NSFetchRequestResult>
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.customCellIdentifier, for: indexPath) as? CustomCell
        if (cell == nil) {
            cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: CustomCell.customCellIdentifier)
        }
        let plant = fetchedResultsController.object(at: indexPath) as! Plant
        // fill cells plant name
        cell?.cellText?.text = plant.name
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId{
            let detailVc = segue.destination as! PlantViewController
            detailVc.initWithPlantNamed((sender as! Plant).name ?? "Undefined")
        }
    } // prepareForSegue
    //Start segue to the view card view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let plant = fetchedResultsController.object(at: indexPath) as! Plant
        performSegue(withIdentifier: segueId, sender: plant)
    }
}
