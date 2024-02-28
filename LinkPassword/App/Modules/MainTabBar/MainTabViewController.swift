//
//  MainTabViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//
import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadVC()
    }
    
    func setupUI() {
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = LinkPassword.Colors.PrimaryText

        tabBar.tintColor = LinkPassword.Colors.PrimaryBtnColor
    }
    
    func loadVC() {
        viewControllers = [homeVC(), settingVC()]
    }

    func homeVC() -> UIViewController {
        let screen = DI.resolver.resolve(HomeViewControllerType.self)!
        screen.hidesBottomBarWhenPushed = false
        let nav = BaseNavigationController(rootViewController: screen)
        nav.tabBarItem = UITabBarItem(title: "Home", image: LinkPassword.Images.tabHomeIcon, selectedImage: LinkPassword.Images.tabHomeSelectedIcon)
        return nav
    }

    func settingVC() -> UIViewController {
        let screen = DI.resolver.resolve(SettingsViewControllerType.self)!
        screen.hidesBottomBarWhenPushed = false
        let nav = BaseNavigationController(rootViewController: screen)
        nav.tabBarItem = UITabBarItem(title: "Settings", image: LinkPassword.Images.tabSettingsIcon, selectedImage: LinkPassword.Images.tabSettingsSelectedIcon)
        return nav
    }

}
