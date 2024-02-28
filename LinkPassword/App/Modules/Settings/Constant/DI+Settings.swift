//
//  DI+Settings.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

extension DI.ViewPairs {
    struct Settings : DIRegistor {
        static func register() {
            let storyboard = UIStoryboard(name: “SettingsViewController", bundle: nil)

            // Settings
            DI.container.register(SettingsViewControllerType.self) { r -> SettingsViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
            }
            DI.container.register(SettingsViewModel.self) { (r) in
                return SettingsViewModel()
            }
        }
    }
}
