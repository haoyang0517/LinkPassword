//
//  DisposeOnWillRemoveFromParentType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import RxSwift
import RxCocoa

protocol DisposeOnWillRemoveFromParentType: class {
    var disposeOnWillRemoveFromParent:Bool { set get }
}
