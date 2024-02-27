//
//  SplashMenuViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class SplashMenuViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let signinDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: SplashMenuViewType? = nil
    
    //MARK: - Initializer
    override init() {
        super.init()
    }
    
    override func dispose() {
        super.dispose()
    }
    
    //MARK: - Transform
    override func transform() {
        super.transform()
                
        let signinDidTap = signinDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToSignin()
            })

        disposeBag.insert(
            signinDidTap
        )
    }
}

extension SplashMenuViewModel {
}
