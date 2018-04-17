import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeTabbarItemsText()

        let vc = Nav1ViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        let nv = UINavigationController(rootViewController: vc)

        let vc2 = Nav2ViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        let nv2 = UINavigationController(rootViewController: vc2)

        let vc3 = Nav2ViewController()
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 3)
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
