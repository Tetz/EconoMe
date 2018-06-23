import UIKit
import SnapKit
import APIKit
import JSONRPCKit
import SwiftIconFont
import KeychainSwift
import Geth

final class TokenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let index: Int
    var titleName: String
    var contractAddress: String
    init(index: Int) {
        self.index = index
        self.titleName = "Ethereum"
        self.contractAddress = ""
        if index == 0 {
            self.titleName = "Ethereum(ETH)"
        } else if index == 1 {
            self.titleName = "OTAKU COIN(XOC)"
            self.contractAddress = "0x98cd8de75f15ceb40a8e8a5f19f19a6f943373f4"
        }
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    let ethHelper = EthereumHelper()
    let (_, account) = EthAccountCoordinator().launch(EthAccountConfiguration.default)

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
        return 230
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
            make.top.equalTo(tokenImgView.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }

        // Send and Receive Button
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let buttonWidth = 160
        let spacer = (Int(screenWidth) - (buttonWidth * 2)) / 3

        // rgb(52, 152, 219)
        let buttonColor = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        let sendButton = UIButton()
        container.addSubview(sendButton)
        sendButton.backgroundColor = buttonColor
        sendButton.layer.cornerRadius = 5
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(self.onTappedSendButton(_:)), for: .touchUpInside)
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(tokenAssetsLabel.snp.bottom).offset(10)
            make.left.equalTo(container).offset(spacer)
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(buttonWidth)
        }

        let receiveButton = UIButton()
        container.addSubview(receiveButton)
        receiveButton.backgroundColor = buttonColor
        receiveButton.layer.cornerRadius = 5
        receiveButton.setTitle("Receive", for: .normal)
        receiveButton.addTarget(self, action: #selector(self.onTappedReceiveButton(_:)), for: .touchUpInside)
        receiveButton.snp.makeConstraints { make in
            make.top.equalTo(tokenAssetsLabel.snp.bottom).offset(10)
            make.right.equalTo(container).offset(-spacer)
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(buttonWidth)
        }

        // TODO
        let address: String? = account!.getAddress().getHex()

        if (index == 0) {
            let request = EthGetBalance(
                    address: address!,
                    quantity: "latest"
            )

            let batch = batchFactory.create(request)
            let httpRequest = EthServiceRequest(batch: batch)

            Session.send(httpRequest) { result in
                switch result {
                case .success(let result):
                    let assets = String(EthereumHelper().weiToEth(result))
                    tokenAssetsLabel.text = "\(assets) ETH"
                case .failure(let error):
                    print(error)
                }
            }
        } else if (index == 1) {
            // Remove 0x prefix
            let addressWithoutPrefix = address!.removeHexPrefix()
            let decimals: Double = 2

            let request = Erc20TokenGetBalance(
                    to: "0x98cd8de75f15ceb40a8e8a5f19f19a6f943373f4",
                    data: "0x70a08231000000000000000000000000" + addressWithoutPrefix,
                    quantity: "latest"
            )

            let batch = batchFactory.create(request)
            let httpRequest = EthServiceRequest(batch: batch)

            Session.send(httpRequest) { result in
                switch result {
                case .success(let result):
                    let assets = String(EthereumHelper().tokenNum(result, decimals: decimals))
                    tokenAssetsLabel.text = "\(assets) XOC"
                case .failure(let error):
                    print(error)
                }
            }
        }

        return container
    }

    @objc private func onTappedSendButton(_: UIButton) {
        let vc = SendViewController(titleName: "Send")
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

    @objc private func onTappedReceiveButton(_: UIButton) {
        let vc = ReceiveViewController(titleName: "Receive")
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

}
