//
//  AboutUsViewController.swift
//  1971
//
//  Created by Mobioapp on 7/1/20.
//  Copyright © 2020 Mobioapp. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtnEvent(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
