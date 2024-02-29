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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)

        if let userEntity = entity {
            let user = NSManagedObject(entity: userEntity, insertInto: context)
            user.setValue(username.value, forKey: "username")
            user.setValue(email.value, forKey: "email")
            user.setValue(password.value, forKey: "password")

            do {
                try context.save()
                // After success save
                self.view?.routeToHome()
            } catch {
                print("Failed to save user: \(error.localizedDescription)")
            }
        }

    }
}
