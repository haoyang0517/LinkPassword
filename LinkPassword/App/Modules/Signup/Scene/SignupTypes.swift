//
//  SignupTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol SignupViewType: BaseViewType {
    func routeToSignin()
    func routeToHome()
}

typealias SignupViewControllerType = UIViewController & SignupViewType
