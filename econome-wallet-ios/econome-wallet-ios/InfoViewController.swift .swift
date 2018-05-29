import UIKit
import SnapKit
import SwiftIconFont

final class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName
        
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
            cell.textLabel?.text = "News 1"
        case 2:
            cell.textLabel?.text = "News 2"
        case 3:
            cell.textLabel?.text = "News 3"
        case 4:
            cell.textLabel?.text = "News 4"
        case 5:
            cell.textLabel?.text = "News 5"
        case 6:
            cell.textLabel?.text = "News 6"
        case 7:
            cell.textLabel?.text = "News 7"
        case 8:
            cell.textLabel?.text = "News 8"
        case 9:
            cell.textLabel?.text = "News 9"
        case 10:
            cell.textLabel?.text = "News 10"
        case 11:
            cell.textLabel?.text = "News 11"
        case 12:
            cell.textLabel?.text = "News 12"
        case 13:
            cell.textLabel?.text = "News 13"
            
        default:
            print("Error: index is not match")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
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
