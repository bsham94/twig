//
//  EncyclopediaTableViewCell.swift
//  Twig
//
//  Created by Zach Merrill on 2021-04-18.
//

import UIKit

class EncyclopediaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
