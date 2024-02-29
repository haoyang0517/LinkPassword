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
            self.view?.routeToHome()
        } else {
            print("fail")
        }
    }
    
    func signIn() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }

        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ OR email == %@", identifier.value, identifier.value)

        do {
            let users = try context.fetch(fetchRequest) as! [NSManagedObject]

            if let user = users.first, let storedPassword = user.value(forKey: "password") as? String {
                return storedPassword == password.value
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }

        return false
    }

}
