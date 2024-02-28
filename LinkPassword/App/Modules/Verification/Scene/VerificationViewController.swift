//
//  VerificationViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class VerificationViewController: BaseViewController<VerificationViewModel> {
    //MARK: - IBOutlets
    @IBOutlet weak var inputContainer: UIStackView!
    @IBOutlet weak var emailContainer: UIStackView!
    @IBOutlet weak var hintTitleLabel: UILabel!
    @IBOutlet weak var hintMessageLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var otpTextFieldView: OTPTextFieldView!
    @IBOutlet weak var nextButton: PrimaryButton!
    @IBOutlet weak var statusContainer: UIStackView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusMessageLabel: UILabel!
    @IBOutlet weak var outsideCloseButton: UIButton!

    //MARK: - Constants
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(VerificationViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .clear
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
extension VerificationViewController {
    
}

//MARK: - <VerificationViewType>
extension VerificationViewController: VerificationViewType {
    
}
