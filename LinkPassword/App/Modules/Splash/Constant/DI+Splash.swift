//
//  DI+Splash.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Splash : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "SplashViewController", bundle: nil)

            // Splash
            DI.container.register(SplashViewControllerType.self) { r -> SplashViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "SplashViewController")
            }
            DI.container.register(SplashViewModel.self) { (r) in
                return SplashViewModel()
            }
        }
    }
}
