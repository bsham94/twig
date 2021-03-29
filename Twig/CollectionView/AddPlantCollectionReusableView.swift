//
//  AddPlantCollectionReusableView.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-29.
//

import UIKit

class AddPlantCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var addPlantButton: UIButton!
    
    override func layoutSubviews() {
        // Override design
        self.addPlantButton.layer.cornerRadius = 15.0
    }
}
