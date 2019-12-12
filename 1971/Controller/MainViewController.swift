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
    
    
    var videoTitleArray = [String]()
    var videoTimeArray = [String]()
    var itemArray = [PopularVideoSingle]()
    var displayImg = UIImage()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    let activity = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularVideoList()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    

   

}


extension MainViewController {
    
    
    func getPopularVideoList(){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = [
                    "api_token" : "www",
                    "page" : "0"
                ]
                self.activity.showLoading(uiView: self.view)
                APICall.shared.callPost(url: URL(string: RECENT_VIDEO)!, httpMethodType: "POST", params: param, finish: self.finishPost)
                self.activity.hide(uiView: self.view)
            }
        } else {
            
            ToastView.shared.long(self.view, txt_msg: "No Internet")
            
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
                self.activity.showLoading(uiView: self.view)
                cellB.videoImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
                self.activity.hide(uiView: self.view)
            }

            return cellB
        }
    }
}
