import UIKit
import SnapKit
import APIKit
import JSONRPCKit
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
    
    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.layer.borderColor = UIColor.red.cgColor
        tableView.tableFooterView = UIView()
        
        // TODO
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TokenListCell.self, forCellReuseIdentifier: "TokenListCell")
        
        // The section header scroll just like any regular cell
        let dummyViewHeight = CGFloat(206)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName
        
        // Release version 1.0
        // let infoImg = UIImage(from: .fontAwesome, code: "envelopeo", backgroundColor: .clear, size: CGSize(width: 30, height: 30))
        // navigationItem.rightBarButtonItem = UIBarButtonItem(image: infoImg, style: .plain, target: self, action: #selector(onTappedRightBarButton))
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TokenListCell", for: indexPath) as! TokenListCell
        cell.titleLab?.text = "ETH"
        cell.despLab?.text = "N/A"
        
        // Keystore
        let keychain = KeychainSwift()
        let address: String? = keychain.get(EtherKeystore().myEtherAddress)
        
        let request = EthGetBalance(
            address: address!,
            quantity: "latest"
        )
        
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)
        
        Session.send(httpRequest) { result in
            switch result {
            case .success(let result):
                cell.despLab?.text = String(strtoul(result, nil, 16))
            case .failure(let error):
                print(error)
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        let walletContent = UIView()
        let grayColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        walletContent.backgroundColor = grayColor
        
        let walletCard:UIImage = UIImage(named:"WalletCard")!
        let walletImageView = UIImageView(image:walletCard)
        walletContent.addSubview(walletImageView)
        walletImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 365, height: 206))
            make.centerX.equalTo(walletContent)
            make.centerY.equalTo(walletContent)
        }
        
        let walletAssetsAmount = UILabel()
        walletImageView.addSubview(walletAssetsAmount)
        walletAssetsAmount.text = "¥ N/A"
        walletAssetsAmount.textColor = UIColor.white
        walletAssetsAmount.font =  UIFont.systemFont(ofSize: 30.0)
        walletAssetsAmount.snp.makeConstraints { make in
            make.left.equalTo(walletImageView).offset(20)
            make.centerY.equalTo(walletImageView)
        }
        
        let keychain = KeychainSwift()
        let address: String? = keychain.get(EtherKeystore().myEtherAddress)
        let walletAddress = UILabel()
        walletImageView.addSubview(walletAddress)
        walletAddress.text = address
        walletAddress.textColor = UIColor.white
        walletAddress.font =  UIFont.systemFont(ofSize: 12.0)
        walletAddress.snp.makeConstraints { make in
            make.left.equalTo(walletImageView).offset(20)
            make.centerY.equalTo(walletImageView).offset(50)
        }
        
        return walletContent
    }
    
    @objc func onTappedRightBarButton(_ sender: UIButton) {
        print(sender)
        let vc = InfoViewController(titleName: "Information")
        navigationController?.pushViewController(vc, animated: true)
    }
}
