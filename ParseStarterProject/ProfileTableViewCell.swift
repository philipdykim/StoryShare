//
//  ProfileTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 6/27/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
