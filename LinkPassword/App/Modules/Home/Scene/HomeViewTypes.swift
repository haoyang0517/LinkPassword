//
//  HomeViewTypes.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol HomeViewType: BaseViewType {
    func routeToAdd()
}

typealias HomeViewControllerType = UIViewController & HomeViewType
