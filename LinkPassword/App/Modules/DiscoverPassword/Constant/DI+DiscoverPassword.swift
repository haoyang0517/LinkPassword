//
//  DI+DiscoverPassword.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct DiscoverPassword : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: “DiscoverPasswordViewController", bundle: nil)

            // DiscoverPassword
            DI.container.register(DiscoverPasswordViewControllerType.self) { r -> DiscoverPasswordViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "DiscoverPasswordViewController")
            }
            DI.container.register(DiscoverPasswordViewModel.self) { (r) in
                return DiscoverPasswordViewModel()
            }
        }
    }
}
