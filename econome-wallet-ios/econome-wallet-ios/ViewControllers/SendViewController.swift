import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation


final class SendViewController: UIViewController {

    let titleName: String
    let addressField = UITextField()
    let amountField = UITextField()

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white

        return container
    }()

    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar
        self.navigationItem.title = titleName
        let closeBtn = UIBarButtonItem(
                title: "Cancel",
                style: .plain,
                target: self,
                action: #selector(self.onTappedLeftBarButton(sender:))
        )
        let nextBtn = UIBarButtonItem(
                title: "Next",
                style: .plain,
                target: self,
                action: #selector(self.onTappedRightBarButton(sender:))
        )

        self.navigationItem.setLeftBarButton(closeBtn, animated: true)
        self.navigationItem.setRightBarButton(nextBtn, animated: true)

        // View
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let fieldWidth = screenWidth - 40

        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let addressLabel = UILabel()
        container.addSubview(addressLabel)
        addressLabel.font = UIFont.systemFont(ofSize: 20)
        addressLabel.textColor = UIColor.darkGray
        addressLabel.text = "To"
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(container).offset(100)
        }

        container.addSubview(addressField)
        addressField.font = UIFont.systemFont(ofSize: 20)
        addressField.placeholder = "0x..."
        addressField.borderStyle = .roundedRect
        addressField.autocapitalizationType = .none
        addressField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.left.equalTo(container).offset(20)
            make.width.equalTo(fieldWidth)
        }

        let amountLabel = UILabel()
        container.addSubview(amountLabel)
        amountLabel.font = UIFont.systemFont(ofSize: 20)
        amountLabel.textColor = UIColor.darkGray
        amountLabel.text = "Amount"
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(addressField.snp.bottom).offset(20)
            make.left.equalTo(container).offset(20)
        }

        container.addSubview(amountField)
        amountField.font = UIFont.systemFont(ofSize: 20)
        amountField.placeholder = "0.0 ETH"
        amountField.borderStyle = .roundedRect
        amountField.autocapitalizationType = .none
        amountField.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.left.equalTo(container).offset(20)
            make.width.equalTo(fieldWidth)
        }


    }

    @objc func onTappedLeftBarButton(sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onTappedRightBarButton(sender: UIBarButtonItem) {
        let vc = ConfirmViewController(titleName: "Confirm", recipientAddress: addressField.text!, amount: amountField.text!)
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

}


