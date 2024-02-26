//
//  UIView+Disposable.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

@objc extension UIView: Disposable {
    @objc public func dispose() {
//        Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)  // too many error, put in subclass
        for subview in subviews {
            subview.dispose()
        }
        self.disposeBag = DisposeBag()
    }
}
