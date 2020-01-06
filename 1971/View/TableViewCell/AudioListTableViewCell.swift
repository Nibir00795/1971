//
//  AudioListTableViewCell.swift
//  1971
//
//  Created by Mobioapp on 6/1/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit

class AudioListTableViewCell: UITableViewCell {

    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var audioAuthorLabel: UILabel!
    @IBOutlet weak var audioDuration: UILabel!
    @IBOutlet weak var audioThumbImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
