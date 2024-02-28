//
//  DI+AddPassword.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct AddPassword : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "AddPasswordViewController", bundle: nil)

            // AddPassword
            DI.container.register(AddPasswordViewControllerType.self) { r -> AddPasswordViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "AddPasswordViewController")
            }
            DI.container.register(AddPasswordViewModel.self) { (r) in
                return AddPasswordViewModel()
            }
        }
    }
}
