import UIKit
import SwiftIconFont

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeTabbarItemsText()
        
        let walletViewController = WalletViewController(titleName: "EconoMe Wallet")
        let walletImage = UIImage(from: .fontAwesome, code: "creditcard", backgroundColor: .clear, size: CGSize(width: 50, height: 50))
        walletViewController.tabBarItem = UITabBarItem(title: "wallet", image: walletImage, tag: 1)
        
        let settingViewController = SettingViewController(titleName: "Setting")
        let settingImg = UIImage(from: .fontAwesome, code: "cog", backgroundColor: .clear, size: CGSize(width: 50, height: 50))
        settingViewController.tabBarItem = UITabBarItem(title: "setting", image: settingImg, tag: 3)
        
        let nv = UINavigationController(rootViewController: walletViewController)
        let nv2 = UINavigationController(rootViewController: settingViewController)
        setViewControllers([nv, nv2], animated: false)
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
