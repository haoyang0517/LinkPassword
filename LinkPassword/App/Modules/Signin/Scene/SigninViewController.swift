//
//  SigninViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SigninViewController: BaseViewController<SigninViewModel> {
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var usernameTextField: CustomIconTextField!
    @IBOutlet weak var passwordTextField: CustomIconTextField!
    @IBOutlet weak var signinButton: PrimaryButton!
    @IBOutlet weak var continueWithLabel: UILabel!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var signupTextButton: UIButton!
    
    //MARK: - Constants
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SigninViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        
        titleLabel.text = "Welcome Back"
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText
        subTitleLabel.text = "Enter your credential to continue"
        subTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 16)
        subTitleLabel.textColor = LinkPassword.Colors.SecondaryText

        usernameTextField.leftIcon = LinkPassword.Images.textfieldUsername
        usernameTextField.placeholder = "Email or username"
        passwordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        passwordTextField.placeholder = "Password"
        passwordTextField.rightSecureButton = true

        signinButton.setTitle("Sign In", for: .normal)
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
    }
}


//MARK: - Helper
extension SigninViewController {
    
}

//MARK: - <SigninViewType>
extension SigninViewController: SigninViewType {
    
}
