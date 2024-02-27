//
//  SplashMenuViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SplashMenuViewController: BaseViewController<SplashMenuViewModel> {
    //MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var primaryButton: PrimaryButton!
    @IBOutlet weak var secondaryButton: SecondaryButton!
    
    //MARK: - Constants
    
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SplashMenuViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .red
        primaryButton.setTitle("Sign Up", for: .normal)
        secondaryButton.setTitle("Sign In", for: .normal)

    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
        
    }
    
    override func subscribe() {
        super.subscribe()
        
        primaryButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinDidTap)
            .disposed(by: disposeBag)
    }
}


//MARK: - Helper
extension SplashMenuViewController {
    
}

//MARK: - <SplashMenuViewType>
extension SplashMenuViewController: SplashMenuViewType {
    func routeToSignin() {
        print("signin")
    }
    
    func routeToSignup() {
        print("signup")

    }
    
    
}
