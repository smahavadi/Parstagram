//
//  PostTableViewCell.swift
//  Parstagram
//
//  Created by Suma Valli on 3/17/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {


    @IBOutlet weak var headerUserLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
