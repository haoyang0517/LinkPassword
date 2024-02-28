//
//  DI+Home.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Home : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)

            // Home
            DI.container.register(HomeViewControllerType.self) { r -> HomeViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            }
            DI.container.register(HomeViewModel.self) { (r) in
                return HomeViewModel()
            }
        }
    }
}
