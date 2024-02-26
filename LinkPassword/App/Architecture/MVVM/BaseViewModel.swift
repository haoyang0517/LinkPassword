//
//  BaseViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: BaseViewModelType, ViewModelType, ReactiveCompatible {
    //MARK: Input
    public var startLoad: Driver<Void> = .never()
    public var startResume: Driver<Void> = .never()
    public var startReload: Driver<Void> = .never()
    public var startLoadMore: Driver<Void> = .never()
    public var startExit: Driver<Void> = .never()
    //MARK: Output
    public var showLoading: Driver<Bool> = .never()
    public var contentReady: Driver<Bool> = .never()
    public var exitWithResult: Driver<DismissResult> = .never()
    //MARK: Dependency
//    @Injected public var buildConfig: BuildConfigType
    @Injected public var Defaults: UserDefaults
    //MARK: State
    
    //MARK: transform
    func transform() {

    }
    
    func subscribe() {
        
    }
    
    func dispose() {
        //Input
        startLoad = .never()
        startResume = .never()
        startReload = .never()
        startExit = .never()
        //Output
        showLoading = .never()
        contentReady = .never()
        exitWithResult = .never()
        //DisposeBag
        disposeBag = DisposeBag()
    }
    
    //MARK: Subscribe Analytics
    func subscribeAnalytics() {
        /* sample subscribing analytics
         let buttonTap = buttonDidTap.drive(onNext: { [unowned self] _ in
            self.analyticManager.track(event: .button(key: "testButton", parameters: ["test_button": "123"]))
        })
        disposeBag.insert(buttonTap)
         */
    }
    
    deinit {

    }
    //MARK: Helper
}
