//
//  ViewModelType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType: DisposeBagHolderType, Disposable {
    func transform()
    func subscribeAnalytics()
}
