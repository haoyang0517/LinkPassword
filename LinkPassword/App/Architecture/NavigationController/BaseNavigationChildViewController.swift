//
//  BaseNavigationChildViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit

@objc protocol BaseNavigationChildViewController {
    @objc optional func willShowInNavigationController(navigationController: UINavigationController, animated: Bool)
    @objc optional var isNavigationBarHidden: Bool { get }
}
