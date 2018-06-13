import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation

final class ReceiveViewController: UIViewController {
    let titleName: String
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    var addBtn: UIBarButtonItem!
    var address: String?

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white

        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar
        self.navigationItem.title = titleName
        let closeBtn = UIBarButtonItem(
                title: "Close",
                style: .plain,
                target: self,
                action: #selector(self.onTappedLeftBarButton(sender:))
        )

        self.navigationItem.setLeftBarButton(closeBtn, animated: true)

        // View
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let receiveLabel = UILabel()
        container.addSubview(receiveLabel)
        receiveLabel.text = "My Public Wallet Address"
        receiveLabel.textColor = UIColor.black
        receiveLabel.font =  UIFont.systemFont(ofSize: 20.0)
        receiveLabel.snp.makeConstraints { make in
            make.top.equalTo(container).offset(100)
            make.centerX.equalTo(container)
        }

        let keychain = KeychainSwift()
        self.address = keychain.get(EtherKeystore().myEtherAddress)
        let walletAddress = UILabel()
        container.addSubview(walletAddress)
        walletAddress.text = address
        walletAddress.textColor = UIColor.black
        walletAddress.font =  UIFont.systemFont(ofSize: 14.0)
        walletAddress.snp.makeConstraints { make in
            make.top.equalTo(receiveLabel.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }

        // rgb(149, 175, 192)
        let buttonColor = UIColor(red: 149/255.0, green: 175/255.0, blue: 192/255.0, alpha: 1.0)
        let sendButton = UIButton()
        container.addSubview(sendButton)
        sendButton.backgroundColor = buttonColor
        sendButton.layer.cornerRadius = 5
        sendButton.setTitle("Copy", for: .normal)
        sendButton.addTarget(self, action: #selector(self.onTappedCopyButton(_:)), for: .touchUpInside)
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(walletAddress.snp.bottom).offset(20)
            make.centerX.equalTo(container)
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(100)
        }

    }

    @objc func onTappedLeftBarButton(sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onTappedCopyButton(_: AnyObject) {
        // Clipboard
        let pasteboard: UIPasteboard = UIPasteboard.general
        pasteboard.string = address!
        print(address!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

}