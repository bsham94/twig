//
//  PlantCollectionViewCell.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-27.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func layoutSubviews() {
        // Override design
        self.layer.cornerRadius = 15.0
    }
}
