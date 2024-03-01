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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentPasswordTextField: CustomIconTextField!
    @IBOutlet weak var newPasswordTextField: CustomIconTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomIconTextField!

    @IBOutlet weak var changePwButton: PrimaryButton!
    
    //MARK: - Constants
    
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(ChangePasswordViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()

        titleLabel.text = "Change \nPassword"
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText

        currentPasswordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        currentPasswordTextField.placeholder = "Current Password"
        currentPasswordTextField.rightSecureButton = true

        newPasswordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        newPasswordTextField.placeholder = "New Password"
        newPasswordTextField.rightSecureButton = true

        confirmPasswordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.rightSecureButton = true

        changePwButton.setTitle("Change Password", for: .normal)
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        let changeBtnTap = changePwButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.changePwDidTap)

        let currentPassword = currentPasswordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)

        let newPassword = newPasswordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.newPassword)

        let confirmPassword = confirmPasswordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.confirmPassword)

        let updateBtn = Observable.combineLatest(viewModel.password, viewModel.newPassword, viewModel.confirmPassword)
            .map { password, newPassword, confirmPassword in
                print("Combine Latest - Current Password: \(password), New Password: \(newPassword), Confirm Password: \(confirmPassword)")
                return !password.isEmpty && !newPassword.isEmpty && !confirmPassword.isEmpty && confirmPassword == newPassword
            }
            .bind(to: changePwButton.rx.isEnabled)

        disposeBag.insert(
            updateBtn,
            changeBtnTap,
            currentPassword,
            newPassword,
            confirmPassword
        )
    }
}


//MARK: - Helper
extension ChangePasswordViewController {
    func routeToVerification(){
        let screen = DI.container.resolve(VerificationViewControllerType.self)!
        screen.newPassword = viewModel.newPassword.value
        screen.modalPresentationStyle = .overFullScreen
        screen.modalTransitionStyle = .crossDissolve
        self.present(screen, animated: true, completion: nil)
    }
}

//MARK: - <ChangePasswordViewType>
extension ChangePasswordViewController: ChangePasswordViewType {
    
}
