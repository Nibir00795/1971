//
//  DocViewerVC.swift
//  1971
//
//  Created by Right on 1/10/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit
import WebKit

class DocViewerVC: UIViewController {

    @IBOutlet weak var docView: UIView!
    @IBOutlet weak var docImg: UIImageView!
    @IBOutlet weak var docTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var docViewer: WKWebView!
    
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var docImageURL = String()
    var docTitleTxt = String()
    var authoeNameTxt = String()
    var docUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docView.roundCorners([.topLeft, .topRight], radius: 20)
        setup()
    }
    
    func setup() {
        let photoURL = "\(imgBasePath)\(docImageURL)"
        
        if let url = URL(string: photoURL) {
            docImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        docTitle.text = docTitleTxt
        authorName.text = authoeNameTxt
        let link = URL(string: "\(imgBasePath)"+"\(docUrl)")!
        print(link)
        
        docViewer.load(URLRequest(url: link))
    }
}

    
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
