//
//  AudioViewController.swift
//  1971
//
//  Created by Mobioapp on 11/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class AudioViewController: UIViewController, SwipeMenuViewDelegate{
    
    
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var audioItemArray = [AudioCategory]()
    var audioInfoArray = [AudioInfo]()
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
        options.tabView.itemView.font = UIFont(name: "Roboto-Medium", size: 18)!
        
        swipeMenuView.reloadData(options: options)
    }
    @IBAction func backButtonEvent(_ sender: Any) {
        print("called")
        self.navigationController?.popViewController(animated: true)
    }
}

extension AudioViewController: SwipeMenuViewDataSource  {
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AudioListViewController") as! AudioListViewController
        vc.preferredContentSize = swipeMenuView.bounds.size
        addChild(vc)
        
        //vc.catId = AudioItemArray[index].id
        
        return vc
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return audioItemArray[index].catName
        
    }
    
    
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return audioItemArray.count
    }
    
    
}

extension AudioViewController {
    
    
    //here is the problem
    func getCategoryList(){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www"]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: API_AUDIO_CATEGORY_LIST)!, httpMethodType: "POST", params: param, finish: self.finishAPost)
                self.activity.hide(uiView: self.view)
                //here man
            }
        } else {
            DispatchQueue.main.async {
                self.activity.hide(uiView: self.view)
                ToastView.shared.long(self.view, txt_msg: "No Internet")
            }
            
            
        }
    }
    

    func finishAPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
                
            {
                print("jsondata", jsonData)
                let parsedData = try JSONDecoder().decode(AudioCategoryList.self, from: jsonData)
                self.audioItemArray.append(contentsOf: parsedData.data)
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

