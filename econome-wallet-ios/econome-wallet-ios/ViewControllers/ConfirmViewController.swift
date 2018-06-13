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
        container.backgroundColor = UIColor.blue

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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

}
