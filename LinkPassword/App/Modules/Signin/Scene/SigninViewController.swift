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
        performExistingAccountSetupFlows()
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        signinButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signinDidTap)
            .disposed(by: disposeBag)
        
        signupTextButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signupDidTap)
            .disposed(by: disposeBag)

        appleButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.signupDidTap)
            .disposed(by: disposeBag)

    }
}


//MARK: - Helper
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
            signUpUser(userIdentifier: userIdentifier, fullName: fullName, email: email)
        }
    }

    func signUpUser(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        print(userIdentifier, fullName, email)
        // Implement your user signup logic here
        // You may want to send the userIdentifier, fullName, and email to your backend for registration

        // For example, you can create a user object and store it locally or send it to your server
        //        let newUser = User(identifier: userIdentifier, fullName: fullName, email: email)

        // Now you can use the newUser object as needed in your app
        // ...

        // Optionally, perform any additional setup or UI updates for the signed-up user
        // ...

        // Finally, navigate to the main content of your app or perform any other relevant actions
        // ...
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

//MARK: - <SigninViewType>
extension SigninViewController: SigninViewType {
    func signinWithApple() {
        performAppleSignIn()
    }
    
    func signinWithGoogle() {
        
    }
    
    func routeToHome() {
        let screen = UIStoryboard(name: "MainTabViewController", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewController")
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen

    }
    
    func routeToSignup() {
        
    }
    
}
