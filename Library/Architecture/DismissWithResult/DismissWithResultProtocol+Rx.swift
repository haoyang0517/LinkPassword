//
//  DismissWithResultProtocol+Rx.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import RxSwift
import RxCocoa

extension Reactive where Base: DismissWithResultProtocol {
    var onDismissResult: Single<DismissResult> {
        return base.onDismissResult.asSingle()
    }
}
