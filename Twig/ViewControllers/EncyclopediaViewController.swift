//
//  EncyclopediaViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit

class EncyclopediaViewController: UIViewController {

    var plants : [Plant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plants = Plant.getAllPlants()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
