//
//  DisposeBagHolderType+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import RxSwift

fileprivate struct AssociatedKey {
    static var disposeBag = "disposeBag"
}
extension DisposeBagHolderType {
    
    var disposeBag:DisposeBag {
        get {
            var ret:DisposeBag? = getAssociatedObject(self, associativeKey: &AssociatedKey.disposeBag)
            if ret == nil {
                ret = DisposeBag()
                setAssociatedObject(self, value: ret, associativeKey: &AssociatedKey.disposeBag)
            }
            return ret!
        }
        
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.disposeBag)
        }
    }
}

extension Disposable where Self: DisposeBagHolderType  {
    func dispose() {
        disposeBag = DisposeBag()
    }
}
