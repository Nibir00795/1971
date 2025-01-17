//
//  PhotoListViewController.swift
//  1971
//
//  Created by Right on 12/20/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class PhotoListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    //let cellIdentifier = "ItemCollectionViewCell"
    var photoInfoArray = [photoInfo]()
    let activity = ActivityIndicator()
    let imgBasePath = "http://glazeitsolutions.com/admin/public/uploads/"
    var catId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getPhotoByCategory(category: catId)
        //getPhotoByCategory(category: "1")
        setupCollectionViewItemSize()

    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        
    }
    
}

extension PhotoListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setupCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
      collectionView.register(nib, forCellWithReuseIdentifier: "itemCell")
    }
    
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            //let numberOfitemForRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 1
            //let width = (collectionView.frame.width - (numberOfitemForRow - 1) * interItemSpacing) / numberOfitemForRow
            let width = (collectionView.frame.width / 2.0) - 10
            let height = width
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("😡\(photoInfoArray.count)")
        return photoInfoArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! PhotoCollectionViewCell
        let photoURL = "\(imgBasePath)\(photoInfoArray[indexPath.row].imgURL)"
        
        if let url = URL(string: photoURL) {
            cell.imageView.layer.cornerRadius = cell.imageView.frame.width/25.0
            cell.imageView.layer.masksToBounds = true
            cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sender:UIButton = UIButton()
        sender.tag = indexPath.row
        self.performSegue(withIdentifier: "photoViewer", sender: sender)
    }
}


extension PhotoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let sender:UIButton = sender as! UIButton
        if segue.identifier == "photoViewer" {
        let photoViewerVC = segue.destination as! PhotoViewerVC
            
            photoViewerVC.imageURL = photoInfoArray[sender.tag].imgURL
            photoViewerVC.imgTitle = photoInfoArray[sender.tag].imgTitle
            photoViewerVC.imgDes = photoInfoArray[sender.tag].imgDesc
        }
    }
    
    func getPhotoByCategory(category: String){
        
        if(Reachability.isConnectedToNetwork()) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            DispatchQueue.main.async {
                
                let param = ["api_token" : "www", "cat_id" : category]
                APICall.shared.callPost(url: URL(string: API_IMAGE_BY_CATEGORY)!, httpMethodType: "POST", params: param, finish: self.photoByCat)
            }
        } else {
            DispatchQueue.main.async {
              MBProgressHUD.hide(for: self.view, animated: true)
                ToastView.shared.long(self.view, txt_msg: "No Internet")
            }
            
            
        }
    }
    func photoByCat (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
                
            {
                print("jsondata", jsonData)
                let parsedData = try JSONDecoder().decode(PhotoByCategory.self, from: jsonData)
                self.photoInfoArray.append(contentsOf: parsedData.data)
                  print("parsedData1", parsedData.data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
               MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
