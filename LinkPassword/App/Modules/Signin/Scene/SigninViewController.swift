//
//  SigninViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import AuthenticationServices

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        performExistingAccountSetupFlows()
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        let identifier = usernameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.identifier)
                
        let password = passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)

        let signinBtnTap = signinButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinDidTap)
        
        let signupBtnTap = signupTextButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signupDidTap)
        
        let appleBtnTap = appleButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinWithAppleDidTap)

        let googleBtnTap = googleButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinWithGoogleDidTap)

        let updateBtn = Observable.combineLatest(viewModel.identifier, viewModel.password)
            .map { identifier, password in
                print("Combine Latest - Identifier: \(identifier), Password: \(password)")
                return !identifier.isEmpty && !password.isEmpty
            }
            .bind(to: signinButton.rx.isEnabled)

        disposeBag.insert(
            identifier,
            password,
            signinBtnTap,
            signupBtnTap,
            appleBtnTap,
            googleBtnTap,
            updateBtn
        )

    }
}

//MARK: - <SigninViewType>
extension SigninViewController: SigninViewType {
    func signinWithApple() {
        print("signin apple")
//        performAppleSignIn()
    }
    
    func signinWithGoogle() {
        print("signin google")
    }
    
    func routeToHome() {
        let screen = UIStoryboard(name: "MainTabViewController", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewController")
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen

    }
    
    func routeToSignup() {
        let screen = DI.resolver.resolve(SignupViewControllerType.self)!
        self.navigationController?.pushViewController(screen)
    }
    
}

//MARK: - Apple Login Helper (can't work rn)
extension SigninViewController: ASAuthorizationControllerDelegate {

    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    // Function to perform Sign in with Apple
    func performAppleSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Handle user authentication with the obtained credential
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // Perform user registration or sign up logic
            signInUser(userIdentifier: userIdentifier, fullName: fullName, email: email)
        }
    }

    func signInUser(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        print(userIdentifier, fullName, email)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In failed with error: \(error.localizedDescription)")
    }

}

extension SigninViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

