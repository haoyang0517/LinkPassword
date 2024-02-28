//
//  ChangePasswordViewTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol ChangePasswordViewType: BaseViewType {
    func routeToVerification()
}

typealias ChangePasswordViewControllerType = UIViewController & ChangePasswordViewType
