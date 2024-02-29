//
//  DiscoverPasswordViewTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol DiscoverPasswordViewType: BaseViewType {
    var password: Password? { set get }

    func copyUsername()
    func copyPassword()
    func dismissDiscover()
}

typealias DiscoverPasswordViewControllerType = UIViewController & DiscoverPasswordViewType
