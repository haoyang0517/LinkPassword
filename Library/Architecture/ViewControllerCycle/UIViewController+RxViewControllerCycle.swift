//
//  UIViewController+RxViewControllerCycle.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    var viewWillAppear: Driver<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:)))
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
        
    var viewDidAppear: Driver<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewDidAppear(_:)))
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
    
    var viewWillDisappear: Driver<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewWillDisappear(_:)))
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
    
    var viewDidDisappear: Driver<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewDidDisappear(_:)))
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
    
    var viewDidLoad: Driver<Void> {
        return base.rx.methodInvoked(#selector(UIViewController.viewDidLoad))
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
}

