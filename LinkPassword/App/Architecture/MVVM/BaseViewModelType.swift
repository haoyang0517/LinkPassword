//
//  BaseViewModelType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModelType: ViewModelType {
    //MARK: Input
    var startLoad: Driver<Void> { set get }
    var startResume: Driver<Void> { set get }
    var startReload: Driver<Void> { set get }
    var startLoadMore: Driver<Void> { set get }
    var startExit: Driver<Void> { set get }
    //MARK: Output
    var showLoading: Driver<Bool> { set get }
    var contentReady: Driver<Bool> { set get }
    var exitWithResult: Driver<DismissResult> { set get }
    //MARK: State
}
