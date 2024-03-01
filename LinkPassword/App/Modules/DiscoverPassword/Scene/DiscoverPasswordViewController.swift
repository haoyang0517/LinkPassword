//
//  DiscoverPasswordViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverPasswordViewController: BaseViewController<DiscoverPasswordViewModel> {
    
    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameCopyButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCopyButton: UIButton!
    @IBOutlet weak var outsideCloseButton: UIButton!

    //MARK: - Constants
    
    //MARK: - Vars
    var password: Password?

    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(DiscoverPasswordViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = .clear
        containerView.layer.cornerRadius = 20
        
        titleLabel.textColor = LinkPassword.Colors.PrimaryText
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 18)
        titleLabel.text = password?.webname
        
        usernameLabel.textColor = LinkPassword.Colors.PrimaryText
        usernameLabel.font = LinkPassword.Fonts.soraSemiBold(size: 14)
        usernameLabel.text = "Copy Username"

        passwordLabel.textColor = LinkPassword.Colors.PrimaryText
        passwordLabel.font = LinkPassword.Fonts.soraSemiBold(size: 14)
        passwordLabel.text = "Copy Password"

    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        let usernameCopyDidTap = usernameCopyButton.rx.tap
            .bind(to: viewModel.usernameCopyDidTap)
        
        let passwordCopyDidTap = passwordCopyButton.rx.tap
            .bind(to: viewModel.passwordCopyDidTap)

        let outsideCloseDidTap = outsideCloseButton.rx.tap
            .bind(to: viewModel.outsideCloseDidTap)

        disposeBag.insert(
            usernameCopyDidTap,
            passwordCopyDidTap,
            outsideCloseDidTap
        )
    }
}


//MARK: - Helper
extension DiscoverPasswordViewController {
    
}

//MARK: - <DiscoverPasswordViewType>
extension DiscoverPasswordViewController: DiscoverPasswordViewType {
    func dismissDiscover() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func copyUsername() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = password?.username

    }
    
    func copyPassword() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = password?.password
    }
}
