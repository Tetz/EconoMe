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

        let walletcard = UIView()
        walletcard.backgroundColor = UIColor.white
        container.addSubview(walletcard)
        walletcard.snp.makeConstraints { make in
            make.width.height.equalTo(self.view.frame.size.height - 98)
            make.width.width.equalTo(container)
            make.centerX.equalTo(container)
            make.top.equalTo(22)
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
            make.left.equalTo(walletcard).offset(10)
            make.bottom.equalTo(walletcard)
        }

        receiveButton.backgroundColor = UIColor.blue
        receiveButton.snp.makeConstraints { make in
            make.width.width.equalTo(self.view.frame.size.width/2 - 15)
            make.left.equalTo(sendButton.snp.right).offset(10)
            make.bottom.equalTo(walletcard)
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
