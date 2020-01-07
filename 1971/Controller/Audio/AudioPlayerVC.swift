//
//  AudioPlayerVC.swift
//  1971
//
//  Created by Mobioapp on 6/1/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerVC: UIViewController {
    
    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var audioThumbImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var startDur: UILabel!
    @IBOutlet weak var endDur: UILabel!
    @IBOutlet weak var playSlider: UISlider!
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playerLayer:AVPlayerLayer?
    var audioInfoArray = [AudioInfo]()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var imgUrl = String()
    var audioTitle = String()
    var index = Int()
    var catId = String()
    
    var startURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSlider.minimumValue = 0
        playSlider.tintColor = UIColor.green
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getAudioByCategory(category: catId)
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        player!.pause()
    }
    
    @IBAction func backBtnEvent(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func prevBtnEvent(_ sender: Any) {
        if(index > 0){
            index = index - 1;
            player!.pause()
            player = nil
            setPlayer();
            if player?.rate == 0
            {
                player!.play()
                playBtn.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
            }
        }
    }
    @IBAction func playBtnEvent(_ sender: Any) {
        if player?.rate == 0
        {
            player!.play()
            playBtn.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        } else {
            player!.pause()
            playBtn.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        }
    }
    @IBAction func nextBtnEvent(_ sender: Any) {
        if(index < audioInfoArray.count - 1){
            index = index + 1
            player!.pause()
            player = nil
            
            setPlayer();
            if player?.rate == 0
            {
                audioTitleLabel.text = "Song Loading...";//NOT WORKING
                player!.play()
                playBtn.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
                
            }
            
        }
    }
    @IBAction func playSliderEvent(_ sender: Any) {
        
        let seconds : Int64 = Int64(playSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player!.play()
        }
    }
}
extension AudioPlayerVC {
    
    func setPlayer(){
        
        
        let urlString = "\(imgBasePath)\(audioInfoArray[index].audioImg)"
        if let url = URL(string: urlString) {
            audioThumbImg.layer.cornerRadius = audioThumbImg.frame.width/16.0
            audioThumbImg.layer.masksToBounds = true
            audioThumbImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        startURL = "\(imgBasePath)\(audioInfoArray[index].audioURL)"
        let url = URL(string: startURL)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        
        playerLayer=AVPlayerLayer(player: player!)
        playerLayer?.frame=CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer!)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        guard !(seconds.isNaN || seconds.isInfinite) else {
          print("nan")
            return  // or some other default string
        }
        let mySecs = Int(seconds) % 60
        let myMins = Int(seconds / 60)
        
        let myTimes = String(myMins) + ":" + String(mySecs);
        endDur.text = myTimes;
        
        
        playSlider.maximumValue = Float(seconds)
        playSlider.isContinuous = false
        playSlider.tintColor = UIColor.green
        
        
        //subroutine used to keep track of current location of time in audio file
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                
                //comment out if you don't want continous play
                if(time == seconds && self.index != self.audioInfoArray.count-1){
                    self.contPlay()
                }
                guard !(time.isNaN || time.isInfinite) else {
                    print("nan")
                   return  // or some other default string
                }
                
                let mySecs2 = Int(time) % 60
                
                if(mySecs2 == 1){//show title of song after 1 second
                    self.audioTitleLabel.text = self.audioInfoArray[self.index].audioTitle;
                }
                let myMins2 = Int(time / 60)
                
                let myTimes2 = String(myMins2) + ":" + String(mySecs2);
                self.startDur.text = myTimes2;//current time of audio track
                
                
                self.playSlider.value = Float ( time );
            }
        }
    }
    func contPlay(){
        
        if(index < audioInfoArray.count - 1){
            index = index + 1;
            
        }
        player!.pause()
        player = nil
        
        setPlayer();
        if player?.rate == 0
        {
            player!.play()
            playBtn.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        }
        
    }
    
    
    func getAudioByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "page" : "0", "cat_id" : category]
                APICall.shared.callPost(url: URL(string: API_AUDIO_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.audioByCat)
            }
        } else {
            DispatchQueue.main.async {
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
                    self.setPlayer()
                }
                
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
