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
import CoreData

final class SigninViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let signinDidTap = PublishSubject<Void>()
    let signupDidTap = PublishSubject<Void>()
    let signinWithAppleDidTap = PublishSubject<Void>()
    let signinWithGoogleDidTap = PublishSubject<Void>()

    let identifier = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

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
                self?.performSignIn()
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
                self?.view?.signinWithGoogle()
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
    
    func performSignIn(){
        if signIn() {
            // Set login status to true
            UserDefaults.isLoggedIn = true
            // Save username
            UserDefaults.username = identifier.value

            self.view?.routeToHome()
        } else {
            print("fail")
        }
    }
    
    func signIn() -> Bool {
        let result = CoreDataManager.shared.signIn(identifier: identifier.value, password: password.value)
        switch result {
        case .success(let success):
            // Return is password match when found user.
            return success
        case .failure(let error):
            print("Failed to login: \(error.localizedDescription)")
            return false
        }
    }

}
