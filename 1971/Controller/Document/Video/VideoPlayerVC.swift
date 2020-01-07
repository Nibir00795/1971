//
//  VideoPlayerVC.swift
//  1971
//
//  Created by Mobioapp on 12/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoPlayerVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var descriptText: UITextView!
    @IBOutlet var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var backButton: UIButton!
    var titleLabelText = String()
    var descript = String()
    var videoURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        descripLabel.text = "Description"
        descriptText.text = descript
        let myVideoURL = NSURL(string: videoURL)
        if Reachability.isConnectedToNetwork() {
            videoPlayer.loadVideoURL(myVideoURL! as URL)
            
        } else {
            DispatchQueue.main.async {
                ToastView.shared.short(self.view, txt_msg:"No Internet")
                ActivityIndicator().hide(uiView: self.view)
            }
        }
    }
    
    @IBAction func backButtonEvent(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
