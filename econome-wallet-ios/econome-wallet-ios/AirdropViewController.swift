import UIKit
import SnapKit
import SwiftIconFont

final class AirdropViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let titleName: String
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName
        let infoImg = UIImage(from: .fontAwesome, code: "envelopeo", backgroundColor: .clear, size: CGSize(width: 30, height: 30))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: infoImg, style: .plain, target: self, action: #selector(onTappedRightBarButton))
        
        let tableView = UITableView()
        tableView.layer.borderColor = UIColor.red.cgColor
        
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let idx = indexPath.row + 1
        
        switch idx {
        case 1:
            cell.textLabel?.text = "Airdrop 1"
        case 2:
            cell.textLabel?.text = "Airdrop 2"
        case 3:
            cell.textLabel?.text = "Airdrop 3"
        case 4:
            cell.textLabel?.text = "Airdrop 4"
        case 5:
            cell.textLabel?.text = "Airdrop 5"
        case 6:
            cell.textLabel?.text = "Airdrop 6"
        default:
            print("Error: index is not match")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index path of the tapped cell: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    @objc func onTappedRightBarButton(_ sender: UIButton) {
        print(sender)
        let vc = InfoViewController(titleName: "Information")
        navigationController?.pushViewController(vc, animated: true)
    }
}
