//
//  PhotoViewerVC.swift
//  1971
//
//  Created by Right on 1/8/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewerVC: UIViewController {

    @IBOutlet weak var photoViewer: UIImageView!
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var imageURL = String()
    var imgTitle = String()
    var imgDes = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoURL = "\(imgBasePath)\(imageURL)"
        
        if let url = URL(string: photoURL) {
            photoViewer.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            photoViewer.enableZoom()
        }
    }
    @IBAction func DescBtn(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "PhotoDescriptionVC") as? PhotoDescriptionVC else { return }
             present(popupVC, animated: true, completion: nil)
             
             popupVC.titleLabel.text = imgTitle
             popupVC.descriptionLabel.text = imgDes
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
