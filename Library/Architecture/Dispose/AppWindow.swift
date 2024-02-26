//
//  AppWindow.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit

class AppWindow: UIWindow {
    override var rootViewController: UIViewController? {
        didSet {
            oldValue?.dispose()
        }
    }
}
