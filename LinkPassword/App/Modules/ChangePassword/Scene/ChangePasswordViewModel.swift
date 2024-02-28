//
//  ChangePasswordViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class ChangePasswordViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let changePwDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: ChangePasswordViewType? = nil
    
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
        
        let changePwDidTap = changePwDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToVerification()
            })

        disposeBag.insert(
            changePwDidTap
        )
    }
}

extension ChangePasswordViewModel {
}
