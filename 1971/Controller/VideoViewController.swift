//
//  VideoViewController.swift
//  1971
//
//  Created by Mobioapp on 11/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class VideoViewController: UIViewController, SwipeMenuViewDelegate{
    
    
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    @IBOutlet weak var videotableView: UITableView!
    
    var itemArray = ["News", "Doccuments", "Song"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .flexible
        options.tabView.margin = 20.0
        options.tabView.additionView.backgroundColor = UIColor(red: 7.0, green: 10.0, blue: 51.0, alpha: 1.0) //UIColor.black//UIColor.customUnderlineColor
        options.tabView.itemView.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.27)
        options.tabView.itemView.selectedTextColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0) //UIColor.black//UIColor.customSelectedTextColor
     //   options.tabView.itemView.font = UIFont(name: "Roboto-Medium", size: 11)!
        
        swipeMenuView.reloadData(options: options)
    }
}


extension VideoViewController: SwipeMenuViewDataSource  {
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
    //    let vc = VideoPlayerVC()
     //   return vc
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return itemArray[index]
    }
    
    
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return itemArray.count
    }
    
    
}
