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
        
                
        disposeBag.insert(
        )
    }
}

extension SigninViewModel {
}
