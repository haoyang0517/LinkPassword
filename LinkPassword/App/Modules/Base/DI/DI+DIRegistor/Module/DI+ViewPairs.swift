//
//  DI+ViewPairs.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit
import SwifterSwift
import Swinject

extension DI {
    struct ViewPairs: DIRegistor {}
}

extension DI.ViewPairs {
    static func register() {
        Splash.register()
        SplashMenu.register()
        Signup.register()
        Signin.register()
        Home.register()
        AddPassword.register()
        Settings.register()
        DiscoverPassword.register()
        ChangePassword.register()
        Verification.register()
    }
}
