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
        // rgb(52, 152, 219)
        let buttonColor = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0)
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = 5
        button.setTitle("Send", for: .normal)
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
