import UIKit
import SnapKit
import SwiftIconFont

final class WalletViewController: UIViewController {
    let titleName: String

    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white

        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName

        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let walletcontent = UIView()
        walletcontent.backgroundColor = UIColor.yellow
        container.addSubview(walletcontent)
        walletcontent.snp.makeConstraints { make in
            make.width.height.equalTo(self.view.frame.size.height - 98)
            make.width.width.equalTo(container)
            make.centerX.equalTo(container)
            make.centerY.equalTo(container)
        }
        
        let otakucoinAmount = UILabel()
        walletcontent.addSubview(otakucoinAmount)
        otakucoinAmount.text = "5000 OTC"
        otakucoinAmount.font =  UIFont.systemFont(ofSize: 40.0)
        otakucoinAmount.snp.makeConstraints { make in
            make.centerX.equalTo(container)
            make.top.equalTo(walletcontent).offset(40)
        }
        
        let myEthAddressLabel = UILabel()
        walletcontent.addSubview(myEthAddressLabel)
        myEthAddressLabel.text = "My Ether Wallet Address:"
        myEthAddressLabel.font =  UIFont.systemFont(ofSize: 25.0)
        myEthAddressLabel.snp.makeConstraints { make in
            make.left.equalTo(walletcontent).offset(10)
            make.top.equalTo(otakucoinAmount.snp.bottom).offset(40)
        }
        
        let myEthAddress = UILabel()
        walletcontent.addSubview(myEthAddress)
        myEthAddress.text = "0x9aE1f5ADFcc383B1C5a85e7f0BBaD4b768e7D661"
        myEthAddress.font =  UIFont.systemFont(ofSize: 14.0)
        myEthAddress.snp.makeConstraints { make in
            make.left.equalTo(walletcontent).offset(10)
            make.top.equalTo(myEthAddressLabel.snp.bottom).offset(0)
        }
        
        let ethAmountLabel = UILabel()
        walletcontent.addSubview(ethAmountLabel)
        ethAmountLabel.text = "ETH Amount:"
        ethAmountLabel.font =  UIFont.systemFont(ofSize: 25.0)
        ethAmountLabel.snp.makeConstraints { make in
            make.left.equalTo(walletcontent).offset(10)
            make.top.equalTo(myEthAddress.snp.bottom).offset(20)
        }
        
        let ethAmount = UILabel()
        walletcontent.addSubview(ethAmount)
        ethAmount.text = "2.3 ETH"
        ethAmount.font =  UIFont.systemFont(ofSize: 20.0)
        ethAmount.snp.makeConstraints { make in
            make.left.equalTo(walletcontent).offset(10)
            make.top.equalTo(ethAmountLabel.snp.bottom).offset(0)
        }
        
        let sendButton = UIButton(type: .system)
        container.addSubview(sendButton)
        sendButton.setTitle("send", for: .normal)
        sendButton.tintColor = UIColor.white
        sendButton.backgroundColor = UIColor.blue
        sendButton.titleLabel?.font =  UIFont.systemFont(ofSize: 32)
        sendButton.addTarget(self, action: #selector(onTappedPush(_:)), for: .touchUpInside)
        
        let receiveButton = UIButton(type: .system)
        container.addSubview(receiveButton)
        receiveButton.setTitle("receive", for: .normal)
        receiveButton.tintColor = UIColor.white
        receiveButton.backgroundColor = UIColor.blue
        receiveButton.titleLabel?.font =  UIFont.systemFont(ofSize: 32)
        receiveButton.addTarget(self, action: #selector(onTappedPush(_:)), for: .touchUpInside)
        

        sendButton.backgroundColor = UIColor.red
        sendButton.snp.makeConstraints { make in
            make.width.width.equalTo(self.view.frame.size.width/2 - 15)
            make.left.equalTo(walletcontent).offset(10)
            make.bottom.equalTo(walletcontent).offset(-10)
        }

        receiveButton.backgroundColor = UIColor.blue
        receiveButton.snp.makeConstraints { make in
            make.width.width.equalTo(self.view.frame.size.width/2 - 15)
            make.left.equalTo(sendButton.snp.right).offset(10)
            make.bottom.equalTo(walletcontent).offset(-10)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onTappedPush(_ sender: UIButton) {
        print(sender)
        let vc = SecondViewController(titleName: "Details")
        navigationController?.pushViewController(vc, animated: true)
    }

}
