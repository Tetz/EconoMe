import UIKit
import SnapKit
import SwiftIconFont

final class AirdropViewController: UIViewController {
    let titleName: String

    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.yellow

        let logo: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        logo.setIcon(from: .FontAwesome, code: "gift", textColor: .blue, backgroundColor: .clear, size: nil)

        container.addSubview(logo)
        logo.backgroundColor = UIColor.white
        logo.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.center.equalTo(container)
        }

        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName

        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
