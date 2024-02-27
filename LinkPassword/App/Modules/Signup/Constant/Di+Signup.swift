//
//  Di+Signup.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Signup : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "SignupViewController", bundle: nil)

            // Signup
            DI.container.register(SignupViewControllerType.self) { r -> SignupViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "SignupViewController")
            }
            DI.container.register(SignupViewModel.self) { (r) in
                return SignupViewModel()
            }
        }
    }
}
