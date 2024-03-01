//
//  VerificationViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class VerificationViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let newPassword = BehaviorRelay<String>(value: "")
    let currentStage = BehaviorRelay<VerificationStageEnum>(value: .one)
    let nextDidTap = PublishSubject<Void>()
    let outsideCloseDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    let checkOTPSignal = PublishSubject<Void>()

    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: VerificationViewType? = nil
    
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
        
        let nextDidTap = nextDidTap
            .subscribe(onNext: { [weak self] _ in
                switch self?.currentStage.value {
                case .one:
                    self?.currentStage.accept(.two)
                case .two:
                    self?.checkOTPSignal.onNext(())
                default:
                    break
                }
            })
                
        let outsideCloseDidTap = outsideCloseDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeBack()
            })

        disposeBag.insert(
            nextDidTap,
            outsideCloseDidTap
        )
    }
}

extension VerificationViewModel {
    func updatePassword(){
        let result =
        CoreDataManager.shared.updatePassword(
            forUsername: UserDefaults.username ?? "",
            newPassword: newPassword.value
        )

        switch result {
        case .success:
            currentStage.accept(.three(true))
        case .failure(let error):
            currentStage.accept(.three(false))

        }
    }
}
