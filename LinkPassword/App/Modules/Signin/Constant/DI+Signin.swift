//
//  DI+Signin.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Signin : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "SigninViewController", bundle: nil)

            // Signin
            DI.container.register(SigninViewControllerType.self) { r -> SigninViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "SigninViewController")
            }
            DI.container.register(SigninViewModel.self) { (r) in
                return SigninViewModel()
            }
        }
    }
}
