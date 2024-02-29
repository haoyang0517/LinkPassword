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
        typeDropDownTextField.dropdownCallback = {
            self.routeToType()
        }

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
        
        let typeChanged = viewModel.type
            .map { type in
                return type.rawValue
            }
            .bind(to: typeDropDownTextField.rx.text)

        // Bind UI elements to ViewModel
        let webname = webnameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.webname)

        let urls = urlTextField.rx.text
            .orEmpty
            .bind(to: viewModel.urls)

        let username = usernameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.username)
        
        let email = emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
        
        let password = passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)

        let updateBtn = Observable.combineLatest(viewModel.type, viewModel.username, viewModel.email, viewModel.password, viewModel.webname, viewModel.urls)
            .map { type, webname, url, username, email, password in
                print("Combine Latest - Type: \(type), Webname: \(webname), url: \(url), Username: \(username), email: \(email), Password: \(password)")
                return !username.isEmpty && !email.isEmpty && !password.isEmpty && !webname.isEmpty && !url.isEmpty
            }
            .bind(to: saveButton.rx.isEnabled)

        let saveBtnTap = saveButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.saveDidTap)

        let cancelBtnTap = cancelButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.cancelDidTap)


        disposeBag.insert(
            typeChanged,
            webname,
            urls,
            username,
            email,
            password,
            updateBtn,
            saveBtnTap,
            cancelBtnTap
        )

    }
}


//MARK: - Helper
extension AddPasswordViewController {
    
}

//MARK: - <AddPasswordViewType>
extension AddPasswordViewController: AddPasswordViewType {
    func routeToType() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Login", style: .default) { _ in
            // Handle login selection
            self.viewModel.type.accept(.login)
        }
        
        let option2 = UIAlertAction(title: "Card", style: .default) { _ in
            // Handle card selection
            self.viewModel.type.accept(.card)
        }
        
        let option3 = UIAlertAction(title: "Others", style: .default) { _ in
            // Handle others selection
            self.viewModel.type.accept(.others)
        }

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(option3)
        alertController.addAction(cancelAction)
                
        present(alertController, animated: true, completion: nil)
    }
    
    func routeBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
