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
    var titleLabelText = String()
    var descript = String()
    var videoURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        descripLabel.text = "Description"
        descriptText.text = descript
        let myVideoURL = NSURL(string: videoURL)
        videoPlayer.loadVideoURL(myVideoURL! as URL)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
