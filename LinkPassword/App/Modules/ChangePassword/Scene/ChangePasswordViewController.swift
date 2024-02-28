//
//  ChangePasswordViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ChangePasswordViewController: BaseViewController<ChangePasswordViewModel> {
    //MARK: - IBOutlets
    //MARK: - Constants
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(ChangePasswordViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .red
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
    }
}


//MARK: - Helper
extension ChangePasswordViewController {
    
}

//MARK: - <ChangePasswordViewType>
extension ChangePasswordViewController: ChangePasswordViewType {
    
}
