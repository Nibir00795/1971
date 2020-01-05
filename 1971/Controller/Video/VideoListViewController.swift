//
//  VideoListViewController.swift
//  1971
//
//  Created by Mobioapp on 18/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SDWebImage

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var videoListTableView: UITableView!
    var videoInfoArray = [VideoInfo]()
    let activity = ActivityIndicator()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var catId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideoByCategory(category: catId)
        

    }
    

}

extension VideoListViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoInfoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoListTableViewCell
        cell.videoTitleLabel.text = videoInfoArray[indexPath.row].title
        cell.videoTimeLabel.text = Converter.timeString(time: TimeInterval(Int(videoInfoArray[indexPath.row].duration)!))
        let urlString = "\(imgBasePath)\(videoInfoArray[indexPath.row].imageName)"
        if let url = URL(string: urlString) {
            cell.thumbImg.layer.cornerRadius = cell.thumbImg.frame.width/16.0
            cell.thumbImg.layer.masksToBounds = true
            cell.thumbImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender:UIButton = UIButton()
        sender.tag = indexPath.row
        self.performSegue(withIdentifier: "videoPlayer", sender: sender)
    }
    
    
    
    
}


extension VideoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sender:UIButton = sender as! UIButton
        if segue.identifier == "videoPlayer" {
        let videoPlayerVc = segue.destination as! VideoPlayerVC
        videoPlayerVc.titleLabelText = videoInfoArray[sender.tag].title
        videoPlayerVc.descript = videoInfoArray[sender.tag].datumDescription ?? "Description not found"
        videoPlayerVc.videoURL = videoInfoArray[sender.tag].youtube
        }
        
        
    }
    
    func getVideoByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "page" : "0", "category" : category]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: API_VIDEO_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.videoByCat)
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
                DispatchQueue.main.async {
                    self.videoListTableView.reloadData()
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}

