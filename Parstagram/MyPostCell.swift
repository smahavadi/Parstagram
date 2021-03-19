//
//  MyPostCell.swift
//  Parstagram
//
//  Created by Suma Valli on 3/18/21.
//

import UIKit

class MyPostCell: UITableViewCell {

    @IBOutlet weak var myHeaderUsernameLabel: UILabel!
    @IBOutlet weak var myPhotoView: UIImageView!
    @IBOutlet weak var myUsernameLabel: UILabel!
    @IBOutlet weak var myCaptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
