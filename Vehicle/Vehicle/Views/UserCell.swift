//
//  UserCell.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ name: String, _ imageUrl: String) {
        userNameLabel.text = name
    }
}
