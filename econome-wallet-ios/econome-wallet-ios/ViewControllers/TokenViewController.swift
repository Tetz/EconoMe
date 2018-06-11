import UIKit
import SnapKit
import APIKit
import JSONRPCKit
import SwiftIconFont
import KeychainSwift

final class TokenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let titleName: String
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    let ethHelper = EthereumHelper()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.layer.borderColor = UIColor.red.cgColor
        tableView.tableFooterView = UIView()

        // Custom cell
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TokenListCell.self, forCellReuseIdentifier: "TokenListCell")

        // The section header scroll just like any regular cell
        let dummyViewHeight = CGFloat(220)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Bar
        navigationItem.title = titleName

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
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
        let container = UIView()
        let grayColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        container.backgroundColor = grayColor

        // View
        let tokenImg:UIImage = UIImage(named:"Token")!
        let tokenImgView = UIImageView(image:tokenImg)
        container.addSubview(tokenImgView)
        tokenImgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(container).offset(20)
            make.centerX.equalTo(container)
        }

        let tokenAssetsLabel = UILabel()
        container.addSubview(tokenAssetsLabel)
        tokenAssetsLabel.text = "¥ N/A"
        tokenAssetsLabel.textColor = UIColor.black
        tokenAssetsLabel.font =  UIFont.systemFont(ofSize: 20.0)
        tokenAssetsLabel.snp.makeConstraints { make in
            make.top.equalTo(tokenImgView).offset(110)
            make.centerX.equalTo(container)
        }

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
                let assets = String(format: "%.2f", self.ethHelper.weiToEth(hex: result))
                tokenAssetsLabel.text = "\(assets) ETH"
            case .failure(let error):
                print(error)
            }
        }


        return container
    }

}
