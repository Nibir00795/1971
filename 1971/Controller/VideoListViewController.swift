//
//  VideoListViewController.swift
//  1971
//
//  Created by Mobioapp on 18/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var videoListTableView: UITableView!
    var videoInfoArray = [VideoInfo]()
    let activity = ActivityIndicator()
    var catId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideoByCategory(category: catId)
        print("id id", videoInfoArray)

    }
    

}

extension VideoListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoListTableViewCell
        cell.videoTitleLabel.text = videoInfoArray[indexPath.row].title
        print("fvjkdfv", videoInfoArray[indexPath.row].title)
        return cell
    }
    
    
    
    
}


extension VideoListViewController {
    func getVideoByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "page" : "0", "category" : category]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: VIDEO_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.videoByCat)
                self.activity.hide(uiView: self.view)
            }
        } else {
            DispatchQueue.main.async {
                self.activity.hide(uiView: self.view)
                ToastView.shared.long(self.view, txt_msg: "No Internet")
            }
            
            
        }
    }
    func videoByCat (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
                
            {
                print("jsondata", jsonData)
                let parsedData = try JSONDecoder().decode(VideoByCategory.self, from: jsonData)
                self.videoInfoArray.append(contentsOf: parsedData.data)
                  print("parsedData1", parsedData.data)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}

