//
//  AudioListViewController.swift
//  1971
//
//  Created by Right on 12/26/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
class AudioListViewController: UIViewController {

    @IBOutlet weak var audioListTableView: UITableView!
    var audioInfoArray = [AudioInfo]()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var catId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAudioByCategory(category: catId)
        
    }
}

extension AudioListViewController : UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioInfoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AudioListCell", for: indexPath) as! AudioListTableViewCell
        cell.audioTitleLabel.text = audioInfoArray[indexPath.row].audioTitle
        cell.audioAuthorLabel.text = audioInfoArray[indexPath.row].audioDescription
        //cell.videoTimeLabel.text = Converter.timeString(time: TimeInterval(Int(audioInfoArray[indexPath.row].d)!))
        let urlString = "\(imgBasePath)\(audioInfoArray[indexPath.row].audioImg)"
        if let url = URL(string: urlString) {
            cell.audioThumbImage.layer.cornerRadius = cell.audioThumbImage.frame.width/16.0
            cell.audioThumbImage.layer.masksToBounds = true
            cell.audioThumbImage.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.audioThumbImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender:UIButton = UIButton()
        sender.tag = indexPath.row
        self.performSegue(withIdentifier: "audioPlayer", sender: sender)
    }
    
    
    
    
}


extension AudioListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sender:UIButton = sender as! UIButton
        if segue.identifier == "audioPlayer" {
        let audioPlayerVc = segue.destination as! AudioPlayerVC
            audioPlayerVc.index = sender.tag
            audioPlayerVc.catId = catId
        }
        
        
    }
    
    func getAudioByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            SVProgressHUD.show()
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "page" : "0", "cat_id" : category]
                APICall.shared.callPost(url: URL(string: API_AUDIO_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.audioByCat)
            }
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                ToastView.shared.long(self.view, txt_msg: "No Internet")
            }
            
            
        }
    }
    func audioByCat (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
                
            {
                print("jsondata", jsonData)
                let parsedData = try JSONDecoder().decode(AudioByCategory.self, from: jsonData)
                self.audioInfoArray.append(contentsOf: parsedData.data)
                  print("parsedData1", parsedData.data)
                DispatchQueue.main.async {
                    self.audioListTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
