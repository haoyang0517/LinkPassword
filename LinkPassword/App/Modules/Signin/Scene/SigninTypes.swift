//
//  SigninTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol SigninViewType: BaseViewType {
    func routeToHome()
    func routeToSignup()
    func signinWithApple()
    func signinWithGoogle()
}

typealias SigninViewControllerType = UIViewController & SigninViewType
