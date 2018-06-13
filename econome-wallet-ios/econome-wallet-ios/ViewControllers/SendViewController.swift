import UIKit
import SnapKit
import SwiftIconFont
import KeychainSwift
import Foundation


final class SendViewController: UIViewController {
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
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // TODO
        let addressLabel = UILabel()
        container.addSubview(addressLabel)
        addressLabel.font = UIFont.systemFont(ofSize: 20)
        addressLabel.text = "To"
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(container).offset(100)
        }

        let addressField = UITextField()
        container.addSubview(addressField)
        addressField.font = UIFont.systemFont(ofSize: 20)
        addressField.placeholder = "0x..."
        addressField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.left.equalTo(container).offset(20)
        }

        let amountLabel = UILabel()
        container.addSubview(amountLabel)
        amountLabel.font = UIFont.systemFont(ofSize: 20)
        amountLabel.text = "Amount"
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(addressField.snp.bottom).offset(20)
            make.left.equalTo(container).offset(20)
        }

        let amountField = UITextField()
        container.addSubview(amountField)
        amountField.font = UIFont.systemFont(ofSize: 20)
        amountField.placeholder = "0.0 ETH"
        amountField.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.left.equalTo(container).offset(20)
        }


    }

    @objc func onTappedLeftBarButton(sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onTappedRightBarButton(sender: UIBarButtonItem) {
        let vc = ConfirmViewController(titleName: "Confirm")
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

}


