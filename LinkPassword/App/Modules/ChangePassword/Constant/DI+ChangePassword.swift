//
//  DI+ChangePassword.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct ChangePassword : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: “ChangePasswordViewController", bundle: nil)

            // ChangePassword
            DI.container.register(ChangePasswordViewControllerType.self) { r -> ChangePasswordViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
            }
            DI.container.register(ChangePasswordViewModel.self) { (r) in
                return ChangePasswordViewModel()
            }
        }
    }
}
