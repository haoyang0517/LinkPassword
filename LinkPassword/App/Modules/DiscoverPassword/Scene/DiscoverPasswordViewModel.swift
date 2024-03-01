//
//  DiscoverPasswordViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class DiscoverPasswordViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let usernameCopyDidTap = PublishSubject<Void>()
    let passwordCopyDidTap = PublishSubject<Void>()
    let outsideCloseDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: DiscoverPasswordViewType? = nil
    
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
        
        let usernameCopyDidTap = usernameCopyDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.copyUsername()
            })

        let passwordCopyDidTap = passwordCopyDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.copyPassword()
            })
                
        let outsideCloseDidTap = outsideCloseDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.dismissDiscover()
            })

        disposeBag.insert(
            usernameCopyDidTap
        )
    }
}

extension DiscoverPasswordViewModel {
}
