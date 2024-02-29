//
//  AddPasswordViewTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol AddPasswordViewType: BaseViewType {
    func routeToType()
    func routeBack()
}

typealias AddPasswordViewControllerType = UIViewController & AddPasswordViewType
