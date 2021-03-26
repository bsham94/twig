//
//  RoomCollectionViewCell.swift
//  Twig
//
//  Created by Zach Merrill on 2021-03-25.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
