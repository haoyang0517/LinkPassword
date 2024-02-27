//
//  DI+SplashMenu.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct SplashMenu : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "SplashMenuViewController", bundle: nil)

            // SplashMenu
            DI.container.register(SplashMenuViewControllerType.self) { r -> SplashMenuViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "SplashMenuViewController")
            }
            DI.container.register(SplashMenuViewModel.self) { (r) in
                return SplashMenuViewModel()
            }
        }
    }
}
