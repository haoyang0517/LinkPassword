//
//  DismissWithResultProtocol+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import RxSwift
import RxCocoa

fileprivate struct AssociatedKey {
    static var dismissIdentifier = "dismissResultIdentifier"
    static var onDismissResult = "onDismissResult"
}
extension DismissWithResultProtocol {
    
    var dismissIdentifier:Any? {
        get {
            let ret:Any? = getAssociatedObject(self, associativeKey: &AssociatedKey.dismissIdentifier)
            return ret
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.dismissIdentifier)
        }
    }
    
    var onDismissResult:PublishRelay<DismissResult> {
        get {
            var ret:PublishRelay<DismissResult>? = getAssociatedObject(self, associativeKey: &AssociatedKey.onDismissResult)
            if ret == nil {
                ret = PublishRelay<DismissResult>()
                setAssociatedObject(self, value: ret, associativeKey: &AssociatedKey.onDismissResult)
            }
            return ret!
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.onDismissResult)
        }
    }
}
