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
    @IBOutlet weak var backButton: UIButton!
    
    
    var itemArray = [CategoryList]()
    var videoInfoArray = [VideoInfo]()
    let activity = ActivityIndicator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self

        getCategoryList()
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .flexible
        options.tabView.margin = 20.0
        options.tabView.additionView.backgroundColor = UIColor(red: 7.0, green: 10.0, blue: 51.0, alpha: 1.0) //UIColor.black//UIColor.customUnderlineColor
        options.tabView.itemView.textColor = UIColor.lightGray
        options.tabView.itemView.selectedTextColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        options.tabView.additionView.underline.height = 0.0
        //UIColor.black//UIColor.customSelectedTextColor
        options.tabView.itemView.font = UIFont(name: "Roboto-Medium", size: 11)!
        
        swipeMenuView.reloadData(options: options)
    }
    @IBAction func backButtonEvent(_ sender: Any) {
        print("called")
        self.navigationController?.popViewController(animated: true)
    }
}


extension VideoViewController: SwipeMenuViewDataSource  {
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VideoListViewController") as! VideoListViewController
        vc.preferredContentSize = swipeMenuView.bounds.size
        addChild(vc)
        
            vc.catId = itemArray[index].id
        
        return vc
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return itemArray[index].title
    }
    
    
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return itemArray.count
    }
    
    
}

extension VideoViewController {
    
    
    
    func getCategoryList(){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www"]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: CATEGORY_LIST)!, httpMethodType: "POST", params: param, finish: self.finishPost)
                self.activity.hide(uiView: self.view)
            }
        } else {
            DispatchQueue.main.async {
                self.activity.hide(uiView: self.view)
                ToastView.shared.long(self.view, txt_msg: "No Internet")
            }
            
            
        }
    }
    

    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
                
            {
                print("jsondata", jsonData)
                let parsedData = try JSONDecoder().decode(VideoCategory.self, from: jsonData)
                self.itemArray.append(contentsOf: parsedData.data)
                DispatchQueue.main.async {
                    self.swipeMenuView.reloadData()
                }
              
                
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
    
}
