//
//  DiscoverPasswordViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverPasswordViewController: BaseViewController<DiscoverPasswordViewModel> {
    //MARK: - IBOutlets
    //MARK: - Constants
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(DiscoverPasswordViewModel.self)!
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
extension DiscoverPasswordViewController {
    
}

//MARK: - <DiscoverPasswordViewType>
extension DiscoverPasswordViewController: DiscoverPasswordViewType {
    
}