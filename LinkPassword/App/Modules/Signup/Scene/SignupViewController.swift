//
//  SignupViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: BaseViewController<SignupViewModel> {
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var usernameTextField: CustomIconTextField!
    @IBOutlet weak var emailTextField: CustomIconTextField!
    @IBOutlet weak var passwordTextField: CustomIconTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomIconTextField!
    @IBOutlet weak var signupButton: PrimaryButton!
    @IBOutlet weak var continueWithLabel: UILabel!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var signinTextButton: UIButton!
    //MARK: - Constants
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SignupViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        
        titleLabel.text = "Create Account"
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText
        subTitleLabel.text = "Sign up to get started!"
        subTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 16)
        subTitleLabel.textColor = LinkPassword.Colors.SecondaryText

        usernameTextField.leftIcon = LinkPassword.Images.textfieldUsername
        usernameTextField.placeholder = "Username"
        emailTextField.leftIcon = LinkPassword.Images.textfieldEmail
        emailTextField.placeholder = "Email address"
        passwordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        passwordTextField.placeholder = "Password"
        passwordTextField.rightSecureButton = true

        confirmPasswordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.rightSecureButton = true
        signupButton.setTitle("Sign Up", for: .normal)
        continueWithLabel.font = LinkPassword.Fonts.soraRegular(size: 11)
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
        
        signinTextButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinDidTap)
            .disposed(by: disposeBag)

    }
}


//MARK: - Helper
extension SignupViewController {
    
}

//MARK: - <SignupViewType>
extension SignupViewController: SignupViewType {
    func routeToSignin() {
        
    }
    
    func routeToHome() {
        
    }
    
}
