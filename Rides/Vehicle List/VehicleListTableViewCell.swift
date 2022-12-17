//
//  VehicleListTableViewCell.swift
//  Rides
//
//  Created by Jay Kaushal on 2022-12-14.
//

import UIKit

class VehicleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var makeLbl: UILabel!
    @IBOutlet weak var vinLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
