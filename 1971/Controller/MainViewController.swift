//
//  MainViewController.swift
//  1971
//
//  Created by Mobioapp on 11/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    @IBOutlet weak var popularVideoCollectionView: UICollectionView!
    @IBOutlet weak var recentVideoCollectionView: UICollectionView!
    @IBOutlet weak var videoView: CardView!
    
    
    var videoTitleArray = [String]()
    var videoTimeArray = [String]()
    var itemArray = [PopularVideoSingle]()
    var displayImg = UIImage()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    let activity = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularVideoList()
        let tapGestureForRCGroupSelection =  UITapGestureRecognizer(target: self, action: #selector (someAction(sender:)))
        tapGestureForRCGroupSelection.numberOfTapsRequired = 1
        videoView.addGestureRecognizer(tapGestureForRCGroupSelection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    @objc func someAction(sender: AnyObject){
        performSegue(withIdentifier: "videoVC", sender: UIButton())
    }
}


extension MainViewController {
    
    
    func getPopularVideoList(){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "page" : "0"]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: RECENT_VIDEO)!, httpMethodType: "POST", params: param, finish: self.finishPost)
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
                let parsedData = try JSONDecoder().decode(PopularVideoList.self, from: jsonData)
                self.itemArray.append(contentsOf: parsedData.data)
                DispatchQueue.main.async {
                    self.popularVideoCollectionView.reloadData()
                    self.recentVideoCollectionView.reloadData()
                }
                print("parsedData", parsedData.data)
                
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
    
    // MARK: - PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sender:UIButton = sender as! UIButton
        if segue.identifier == "videoVC" {
        let viewController = segue.destination as! VideoViewController
        }
        else if segue.identifier == "video" {
        let videoPlayerVc = segue.destination as! VideoPlayerVC
        videoPlayerVc.titleLabelText = itemArray[sender.tag].title
        videoPlayerVc.descript = itemArray[sender.tag].datumDescription ?? "Description not found"
        videoPlayerVc.videoURL = itemArray[sender.tag].youtube
        }
        
        
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularVideoCollectionView {
            
            return itemArray.count
        }
        
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularVideoCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularVideoCollectionViewCell
            cellA.videoTitleLabel.text = itemArray[indexPath.row].title
            cellA.videoTimeLabel.text = Converter.timeString(time: TimeInterval(Int(itemArray[indexPath.row].duration)!))
            let urlString = "\(imgBasePath)\(itemArray[indexPath.row].imageName)"
            if let url = URL(string: urlString) {
                cellA.videoImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            return cellA
        }
            
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath) as! RecentVideoCollectionViewCell
            
            cellB.videoTitleLabel.text = itemArray[indexPath.row].title
            cellB.videoTimeLabel.text = Converter.timeString(time: TimeInterval(Int(itemArray[indexPath.row].duration)!))
            let urlString = "\(imgBasePath)\(itemArray[indexPath.row].imageName)"
            if let url = URL(string: urlString) {
                cellB.videoImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))            }
            
            return cellB
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sender:UIButton = UIButton()
        sender.tag = indexPath.row
        self.performSegue(withIdentifier: "video", sender: sender)
    }
}
