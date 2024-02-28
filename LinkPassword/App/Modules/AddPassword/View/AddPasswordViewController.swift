//
//  AddPasswordViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class AddPasswordViewController: BaseViewController<AddPasswordViewModel> {
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var typeTitleLabel: UILabel!
    @IBOutlet weak var typeDropDownTextField: DropdownTextField!
    
    
    @IBOutlet weak var webnameTitleLabel: UILabel!
    @IBOutlet weak var webnameTextField: CustomTextField!

    @IBOutlet weak var urlTitleLabel: UILabel!
    @IBOutlet weak var urlTextField: CustomTextField!

    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: CustomIconTextField!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: CustomIconTextField!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordTextField: CustomIconTextField!

    @IBOutlet weak var saveButton: PrimaryButton!
    @IBOutlet weak var cancelButton: UIButton!
    //MARK: - Constants
    
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(AddPasswordViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        
        titleLabel.text = "Add Item"
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        titleLabel.textColor = LinkPassword.Colors.PrimaryText

        subTitleLabel.text = "Secured your password."
        subTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 16)
        subTitleLabel.textColor = LinkPassword.Colors.SecondaryText

        typeTitleLabel.text = "Type"
        typeTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        typeTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        
        webnameTitleLabel.text = "Web Name"
        webnameTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        webnameTitleLabel.textColor = LinkPassword.Colors.PrimaryText

        urlTitleLabel.text = "URLs"
        urlTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        urlTitleLabel.textColor = LinkPassword.Colors.PrimaryText

        usernameTitleLabel.text = "Username"
        usernameTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        usernameTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        usernameTextField.leftIcon = LinkPassword.Images.textfieldUsername

        emailTitleLabel.text = "Email"
        emailTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        emailTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        emailTextField.leftIcon = LinkPassword.Images.textfieldEmail

        passwordTitleLabel.text = "Password"
        passwordTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        passwordTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        passwordTextField.leftIcon = LinkPassword.Images.textfieldPassword
        passwordTextField.rightSecureButton = true

        saveButton.setTitle("Save", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
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
extension AddPasswordViewController {
    
}

//MARK: - <AddPasswordViewType>
extension AddPasswordViewController: AddPasswordViewType {
    
}
