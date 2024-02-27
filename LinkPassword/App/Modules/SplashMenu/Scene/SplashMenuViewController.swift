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
    
    @IBOutlet weak var signupButton: PrimaryButton!
    @IBOutlet weak var signinButton: SecondaryButton!
    
    //MARK: - Constants
    
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SplashMenuViewModel.self)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setupView() {
        super.setupView()
        signupButton.setTitle("Sign Up", for: .normal)
        signinButton.setTitle("Sign In", for: .normal)
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
        
    }
    
    override func subscribe() {
        super.subscribe()
        
        signupButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signupDidTap)
            .disposed(by: disposeBag)
        
        signinButton.rx.tap
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
        let screen = DI.resolver.resolve(SigninViewControllerType.self)!
        self.navigationController?.pushViewController(screen)
    }
    
    func routeToSignup() {
        let screen = DI.resolver.resolve(SignupViewControllerType.self)!
        self.navigationController?.pushViewController(screen)
    }
    
    
}
