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
    }
}


//MARK: - Helper
extension ChangePasswordViewController {
    
}

//MARK: - <ChangePasswordViewType>
extension ChangePasswordViewController: ChangePasswordViewType {
    
}
