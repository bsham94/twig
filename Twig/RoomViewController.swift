//
//  RoomViewController.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-26.
//

import UIKit

class RoomViewController: UIViewController {
    
    // MARK: Properties
    private var room:Room?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        self.title = room?.getName() ?? "Undefined"
        
    } // viewDidLoad
    
    // MARK: Mutators
    func initWithRoom(_ room:Room){
        self.room = room
    } // initWithRoom

}
