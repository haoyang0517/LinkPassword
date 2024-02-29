//
//  AddPasswordViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift
import CoreData

final class AddPasswordViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let typeDidTap = PublishSubject<Void>()
    let saveDidTap = PublishSubject<Void>()
    let cancelDidTap = PublishSubject<Void>()

    let type = BehaviorRelay<PasswordCategory>(value: .card)
    let webname = BehaviorRelay<String>(value: "")
    let urls = BehaviorRelay<String>(value: "")
    let username = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: AddPasswordViewType? = nil
    
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
        
        let saveDidTap = saveDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.savePasswordForUser()
            })

        let cancelDidTap = cancelDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeBack()
            })

        disposeBag.insert(
            saveDidTap,
            cancelDidTap
        )
    }
}

extension AddPasswordViewModel {
    func savePasswordForUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        guard let usernameToFetch = UserDefaults.username else {
            print("UserDefaults username is nil")
            return
        }

        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ OR email == %@", usernameToFetch, usernameToFetch)

        do {
            let users = try context.fetch(fetchRequest)

            if let user = users.first {
                let newPassword = Password(context: context)
                newPassword.type = type.value.rawValue
                newPassword.webname = webname.value
                newPassword.urls = urls.value
                newPassword.username = username.value
                newPassword.email = email.value
                newPassword.password = password.value

                // Add the password to the user's passwords
                user.addToPasswords(newPassword)

                // Save the changes
                try context.save()

                print("Password saved for user \(usernameToFetch)")
                
                self.view?.routeBack()
                
            } else {
                print("User not found for username \(usernameToFetch)")
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }


}
