//
//  CustomCell.swift
//  Twig
//
//  Created by ben shamas on 2021-04-17.
//

import UIKit

class CustomCell: UITableViewCell {

    //@IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var cellText : UILabel!
    
    
    static let customCellIdentifier = "reuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
