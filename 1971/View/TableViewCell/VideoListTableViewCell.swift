//
//  VideoListTableViewCell.swift
//  1971
//
//  Created by Mobioapp on 18/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {

    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var videoTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
