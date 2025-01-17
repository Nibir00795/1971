//
//  ViewControllerUtils.swift
//  JCH VCC
//
//  Created by Sami on 1/31/19.
//  Copyright © 2019 Sami. All rights reserved.
//

import Foundation
import UIKit

@objc open class ActivityIndicator:NSObject {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
     @objc func showLoading(uiView: UIView?) {
        if let uiView = uiView {
            container.frame = uiView.frame
            container.center = uiView.center
            container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0)
            
            loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
            loadingView.center = uiView.center
            loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.4)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
            activityIndicator.assignColor(UIColor.white)
            
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            uiView.addSubview(container)
            activityIndicator.startAnimating()
        }
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    @objc func hide(uiView: UIView?) {
        if let uiView = uiView {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.container.removeFromSuperview()
            }
        }
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

extension UIActivityIndicatorView {
    func assignColor(_ color: UIColor) {
        style = .whiteLarge
        self.color = color
    }
}
