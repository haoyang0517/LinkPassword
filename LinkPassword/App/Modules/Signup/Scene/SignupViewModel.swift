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
import CoreData

final class SignupViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let signinDidTap = PublishSubject<Void>()
    let signupDidTap = PublishSubject<Void>()

    let username = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let confirmPassword = BehaviorRelay<String>(value: "")

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
                self?.signup()
            })

        disposeBag.insert(
            signinDidTap,
            signupDidTap
        )
    }
}

extension SignupViewModel {
    
    func signup(){
        let result = CoreDataManager.shared.signup(username: username.value, email: email.value, password: password.value)
        switch result {
        case .success(let success):
            // Store user info to userdefaults
            UserDefaults.isLoggedIn = true
            UserDefaults.username = username.value
            // Navigate
            self.view?.routeToHome()
        case .failure(let error):
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
}
