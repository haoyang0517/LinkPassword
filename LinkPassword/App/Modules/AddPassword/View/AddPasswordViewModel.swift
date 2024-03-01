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
        let result = CoreDataManager.shared.savePasswordForUser(
            type: type.value,
            webname: webname.value,
            urls: urls.value,
            username: username.value,
            email: email.value,
            password: password.value
        )

        switch result {
        case .success:
            self.view?.routeBack()
        case .failure(let error):
            print("Error saving password: \(error.localizedDescription)")
        }
    }

}
