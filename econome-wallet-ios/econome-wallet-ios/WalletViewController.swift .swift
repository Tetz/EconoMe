import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift

final class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let titleName: String
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var container: UITableView = {
        let container = UITableView()
        container.backgroundColor = UIColor.white
        container.layer.borderColor = UIColor.red.cgColor
        
        // The section header scroll just like any regular cell
        let dummyViewHeight = CGFloat(206)
        container.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: container.bounds.size.width, height: dummyViewHeight))
        container.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
        
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName
        let infoImg = UIImage(from: .fontAwesome, code: "envelopeo", backgroundColor: .clear, size: CGSize(width: 30, height: 30))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: infoImg, style: .plain, target: self, action: #selector(onTappedRightBarButton))
        
        container.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        container.delegate = self
        container.dataSource = self
        self.view.addSubview(container)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let idx = indexPath.row + 1
        
        switch idx {
        case 1:
            cell.textLabel?.text = "Bounty 1"
        case 2:
            cell.textLabel?.text = "Bounty 2"
        case 3:
            cell.textLabel?.text = "Bounty 3"
        case 4:
            cell.textLabel?.text = "Bounty 4"
        case 5:
            cell.textLabel?.text = "Bounty 5"
        case 6:
            cell.textLabel?.text = "Bounty 6"
        case 7:
            cell.textLabel?.text = "Bounty 7"
        case 8:
            cell.textLabel?.text = "Bounty 8"
        case 9:
            cell.textLabel?.text = "Bounty 9"
        default:
            print("Error: index is not match")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index path of the tapped cell: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let walletcontent = UIView()
        let grayColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        walletcontent.backgroundColor = grayColor
        
        return walletcontent
    }
    
    @objc func onTappedRightBarButton(_ sender: UIButton) {
        print(sender)
        let vc = InfoViewController(titleName: "Information")
        navigationController?.pushViewController(vc, animated: true)
    }
}