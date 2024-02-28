//
//  SignupViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class SignupViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let signinDidTap = PublishSubject<Void>()
    let signupDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: SignupViewType? = nil
    
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

        let signupDidTap = signupDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToHome()
            })

        disposeBag.insert(
            signinDidTap,
            signupDidTap
        )
    }
}

extension SignupViewModel {
}
