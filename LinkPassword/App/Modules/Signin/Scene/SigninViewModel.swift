//
//  SigninViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class SigninViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let signinDidTap = PublishSubject<Void>()
    let signupDidTap = PublishSubject<Void>()
    let signinWithAppleDidTap = PublishSubject<Void>()
    let signinWithGoogleDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: SigninViewType? = nil
    
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
                self?.view?.routeToHome()
            })

        let signupDidTap = signupDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToSignup()
            })

        let signinWithAppleDidTap = signinWithAppleDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.signinWithApple()
            })

        let signinWithGoogleDidTap = signinWithGoogleDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.signinWithApple()
            })

        disposeBag.insert(
            signinDidTap,
            signupDidTap,
            signinWithAppleDidTap,
            signinWithGoogleDidTap
        )
    }
}

extension SigninViewModel {
}
