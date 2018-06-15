import UIKit
import SnapKit
import SwiftIconFont
import Foundation

final class ConfirmViewController: UIViewController {
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
        navigationItem.title = titleName

        // View
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let button = UIButton()
        container.addSubview(button)

        let addressTitleLabel = UILabel()
        container.addSubview(addressTitleLabel)
        addressTitleLabel.font = UIFont.systemFont(ofSize: 20)
        addressTitleLabel.textColor = UIColor.darkGray
        addressTitleLabel.text = "Recipient"
        addressTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(container).offset(100)
        }

        let addressLabel = UILabel()
        container.addSubview(addressLabel)
        addressLabel.font = UIFont.systemFont(ofSize: 20)
        addressLabel.textColor = UIColor.black
        addressLabel.text = "0x..."
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(addressTitleLabel.snp.bottom).offset(10)
        }

        let amountTitleLabel = UILabel()
        container.addSubview(amountTitleLabel)
        amountTitleLabel.font = UIFont.systemFont(ofSize: 20)
        amountTitleLabel.textColor = UIColor.darkGray
        amountTitleLabel.text = "Amount"
        amountTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
        }

        let amountLabel = UILabel()
        container.addSubview(amountLabel)
        amountLabel.font = UIFont.systemFont(ofSize: 20)
        amountLabel.textColor = UIColor.black
        amountLabel.text = "0.0 ETH"
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(amountTitleLabel.snp.bottom).offset(10)
        }

        let gasTitleLabel = UILabel()
        container.addSubview(gasTitleLabel)
        gasTitleLabel.font = UIFont.systemFont(ofSize: 20)
        gasTitleLabel.textColor = UIColor.darkGray
        gasTitleLabel.text = "Est. Network Fees"
        gasTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(amountLabel.snp.bottom).offset(20)
        }

        let gasLabel = UILabel()
        container.addSubview(gasLabel)
        gasLabel.font = UIFont.systemFont(ofSize: 20)
        gasLabel.textColor = UIColor.black
        gasLabel.text = "0.0 ETH"
        gasLabel.snp.makeConstraints { make in
            make.left.equalTo(container).offset(20)
            make.top.equalTo(gasTitleLabel.snp.bottom).offset(10)
        }

        // rgb(52, 152, 219)
        let buttonColor = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = 5
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        // SnapKit
        button.snp.makeConstraints { make in
            make.centerX.equalTo(container)
            make.bottom.equalTo(container).offset(-20)
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(330)
        }

    }

    @objc private func buttonTapped(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

}
