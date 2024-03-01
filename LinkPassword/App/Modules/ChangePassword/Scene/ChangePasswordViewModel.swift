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

    let password = BehaviorRelay<String>(value: "")
    let newPassword = BehaviorRelay<String>(value: "")
    let confirmPassword = BehaviorRelay<String>(value: "")

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
                self?.editPassword()
            })

        disposeBag.insert(
            changePwDidTap
        )
    }
}

extension ChangePasswordViewModel {
    func editPassword(){
        let result = 
        CoreDataManager.shared.checkCurrentPassword(
            forUsername: UserDefaults.username ?? "",
            currentPassword: password.value
        )

        switch result {
        case .success:
            print("Current password matched, proceed verification")
            self.view?.routeToVerification()
        case .failure(let error):
            print("Check Password Fail, \(error.localizedDescription)")
        }

    }
}
