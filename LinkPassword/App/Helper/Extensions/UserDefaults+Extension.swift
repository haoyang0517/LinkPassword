//
//  UserDefaults+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import Foundation

extension UserDefaults {
    private static let isLoggedInKey = "isLoggedIn"
    private static let usernameKey = "username"

    static var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoggedInKey)
        }
    }

    static var username: String? {
        get {
            return UserDefaults.standard.string(forKey: usernameKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
}
