//
//  SplashMenuTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol SplashMenuViewType: BaseViewType {
    func routeToSignin()
    func routeToSignup()
}

typealias SplashMenuViewControllerType = UIViewController & SplashMenuViewType
