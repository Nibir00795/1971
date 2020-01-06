//
//  AudioPlayerVC.swift
//  1971
//
//  Created by Mobioapp on 6/1/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit

class AudioPlayerVC: UIViewController {

    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var audioThumbImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var imgUrl = String()
    var audioTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        audioTitleLabel.text = audioTitle
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let urlString = "\(imgBasePath)\(imgUrl)"
        if let url = URL(string: urlString) {
            audioThumbImg.layer.cornerRadius = audioThumbImg.frame.width/16.0
            audioThumbImg.layer.masksToBounds = true
            audioThumbImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
    }

    @IBAction func backBtnEvent(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

