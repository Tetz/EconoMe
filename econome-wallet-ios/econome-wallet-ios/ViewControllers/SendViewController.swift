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

    var addBtn: UIBarButtonItem!

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.green

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