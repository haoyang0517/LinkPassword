//
//  DisposeOnWillRemoveFromParentType+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit

fileprivate struct AssociatedKey {
    static var disposeOnWillRemoveFromParent = "disposeOnWillRemoveFromParent"
    static var isDisposed = "isDisposed"
}

extension DisposeOnWillRemoveFromParentType {
    public var disposeOnWillRemoveFromParent:Bool {
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.disposeOnWillRemoveFromParent)
        }
        get {
            let o: Bool? = getAssociatedObject(self, associativeKey: &AssociatedKey.disposeOnWillRemoveFromParent)
            return o ?? true
        }
    }
    
    public var isDisposed:Bool {
        set {
            setAssociatedObject(self, value: newValue, associativeKey: &AssociatedKey.isDisposed)
        }
        get {
            let o: Bool? = getAssociatedObject(self, associativeKey: &AssociatedKey.isDisposed)
            return o ?? true
        }
    }
}
