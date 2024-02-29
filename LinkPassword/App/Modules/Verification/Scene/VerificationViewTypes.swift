//
//  VerificationViewTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol VerificationViewType: BaseViewType {
    var newPassword: String? { set get }
    
    func routeBack()
}

typealias VerificationViewControllerType = UIViewController & VerificationViewType
