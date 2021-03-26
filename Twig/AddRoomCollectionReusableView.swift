//
//  AddRoomCollectionReusableView.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-26.
//

import UIKit

class AddRoomCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var addRoomButton: UIButton!
    
    override func layoutSubviews() {
        // Override design
        self.addRoomButton.layer.cornerRadius = 15.0
    }
}
