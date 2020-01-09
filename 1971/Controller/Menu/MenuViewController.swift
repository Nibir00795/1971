
import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}

protocol MenuViewControllerDelegate {
    func leftMenuCellClicked()
    
}

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var leftMenuTableView: UITableView!
    var itemNameArray = ["About Us","Contect Us","Rate Us","Privacy Policy"]
    var delegateManager : MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuTableView.delegate = self
        leftMenuTableView.dataSource = self
        setUpView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        leftMenuTableView.layer.zPosition = 1
        leftMenuTableView.reloadData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
}

extension MenuViewController {
    
    func setUpView()  {
        
        leftMenuTableView.allowsSelection = true
        leftMenuTableView.delegate = self
        leftMenuTableView.dataSource = self
        leftMenuTableView.layer.zPosition = 1
        self.leftMenuTableView.rowHeight = UITableView.automaticDimension;
        leftMenuTableView.separatorColor = UIColor(hex : 0x000000)
        leftMenuTableView.tableFooterView = UIView()
    }
}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        cell.cellLabel.text = itemNameArray[indexPath.row]
        cell.cellLabel.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            
        if indexPath.row == 0 {
            self.delegateManager?.leftMenuCellClicked()
            self.performSegue(withIdentifier: "aboutUs", sender: nil)
            
        } else if indexPath.row == 1 {
            self.delegateManager?.leftMenuCellClicked()
            self.performSegue(withIdentifier: "contactUs", sender: nil)
            
        } else if indexPath.row == 2 {
            self.delegateManager?.leftMenuCellClicked()
            UserDefaults.standard.set(nil, forKey: "rateUs")
            
        } else if indexPath.row == 3 {
            self.delegateManager?.leftMenuCellClicked()
            UserDefaults.standard.set(nil, forKey: "privacy")
            
        }
    }
    


    
}


