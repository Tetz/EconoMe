import UIKit
import SwiftIconFont

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeTabbarItemsText()

        let vc = Nav1ViewController()
        let walletLogo = UIImage(from: .FontAwesome, code: "creditcard", textColor: .black, backgroundColor: .clear, size: CGSize(width: 50, height: 50))
        vc.tabBarItem = UITabBarItem(title: "wallet", image: walletLogo, tag: 1)
        let nv = UINavigationController(rootViewController: vc)

        let vc2 = Nav2ViewController()
        let airdropLogo = UIImage(from: .FontAwesome, code: "gift", textColor: .black, backgroundColor: .clear, size: CGSize(width: 50, height: 50))
        vc2.tabBarItem = UITabBarItem(title: "airdrop", image: airdropLogo, tag: 2)
        let nv2 = UINavigationController(rootViewController: vc2)

        let vc3 = Nav2ViewController()
        let settingLogo = UIImage(from: .FontAwesome, code: "cog", textColor: .black, backgroundColor: .clear, size: CGSize(width: 50, height: 50))
        vc3.tabBarItem = UITabBarItem(title: "setting", image: settingLogo, tag: 3)
        let nv3 = UINavigationController(rootViewController: vc3)

        setViewControllers([nv, nv2, nv3], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func removeTabbarItemsText() {
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            }
        }
    }
}
