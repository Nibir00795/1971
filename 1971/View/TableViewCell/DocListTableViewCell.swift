//
//  DocViewTableViewCell.swift
//  1971
//
//  Created by Right on 12/27/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit

class DocListTableViewCell: UITableViewCell {

    @IBOutlet weak var tumbImg: UIImageView!
    @IBOutlet weak var docTitle: UILabel!
    @IBOutlet weak var DocAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
