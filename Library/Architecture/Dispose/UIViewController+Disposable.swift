//
//  UIViewController+Disposable.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

@objc extension UIViewController: Disposable {
    @objc public func dispose() {
        for child in children {
            child.dispose()
        }
        if isViewLoaded {
            view.dispose()
        }
        self.disposeBag = DisposeBag()
    }
}
