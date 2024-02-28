//
//  DI+Verification.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Verification : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: "VerificationViewController", bundle: nil)

            // Verification
            DI.container.register(VerificationViewControllerType.self) { r -> VerificationViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "VerificationViewController")
            }
            DI.container.register(VerificationViewModel.self) { (r) in
                return VerificationViewModel()
            }
        }
    }
}
