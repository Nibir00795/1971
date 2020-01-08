//
//  DocListViewController.swift
//  1971
//
//  Created by Right on 12/27/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class DocListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var docInforArry = [DocInfo]()
    let activity = ActivityIndicator()
    let BasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var catId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDocByCategory(category: catId)
    }
}

extension DocListViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docInforArry.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell", for: indexPath) as! DocListTableViewCell
        cell.docTitle.text = docInforArry[indexPath.row].docTitle
        cell.DocAuthor.text = docInforArry[indexPath.row].docAuthor
        let urlString = "\(BasePath)\(docInforArry[indexPath.row].docImgURL)"
        if let url = URL(string: urlString) {
            cell.tumbImg.layer.cornerRadius = cell.tumbImg.frame.width/16.0
            cell.tumbImg.layer.masksToBounds = true
            cell.tumbImg.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.tumbImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender:UIButton = UIButton()
        sender.tag = indexPath.row
        self.performSegue(withIdentifier: "docViewer", sender: sender)
    }
    
    
    
    
}


extension DocListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sender:UIButton = sender as! UIButton
        if segue.identifier == "docViewer" {
      //  let videoPlayerVc = segue.destination as! VideoPlayerVC
      //  videoPlayerVc.titleLabelText = docInforArry[sender.tag].docTitle
        //videoPlayerVc.descript = docInforArry[sender.tag].datumDescription ?? "Description not found"
        //videoPlayerVc.videoURL = docInforArry[sender.tag].youtube
        }
        
        
    }
    
    func getDocByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            SVProgressHUD.show()
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "cat_id" : category]
                APICall.shared.callPost(url: URL(string: API_DOC_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.videoByCat)
            }
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
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
                let parsedData = try JSONDecoder().decode(DocByCategory.self, from: jsonData)
                self.docInforArry.append(contentsOf: parsedData.data)
                  print("parsedData1", parsedData.data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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

