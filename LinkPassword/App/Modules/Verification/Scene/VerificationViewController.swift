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
    var newPassword: String?
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(VerificationViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .clear
        hintTitleLabel.text = "Enter 4 Digits Code"
        hintTitleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 18)
        hintTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        
        hintMessageLabel.text = "Enter your email for the verification proccess, we will send 4 digits code to your email."
        hintMessageLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        hintMessageLabel.textColor = LinkPassword.Colors.SecondaryText

        emailTitleLabel.text = "Email"
        emailTitleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 14)
        emailTitleLabel.textColor = LinkPassword.Colors.PrimaryText
        
        emailTextField.placeholder = "Enter your email"
        nextButton.setTitle("Send", for: .normal)
        
        statusTitleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 18)
        statusTitleLabel.textColor = LinkPassword.Colors.PrimaryText

        statusMessageLabel.font = LinkPassword.Fonts.soraRegular(size: 14)
        statusMessageLabel.textColor = LinkPassword.Colors.SecondaryText

    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
        viewModel.newPassword.accept(newPassword ?? "")
    }
    
    override func subscribe() {
        super.subscribe()
        
        let stageChanged = viewModel.currentStage
            .subscribe(onNext: { [weak self] stage in
                self?.updateCurrentStageUI(stage: stage)
            })
        
        let checkOtp = viewModel.checkOTPSignal
            .flatMapLatest { [weak self] _ in
                return self?.otpTextFieldView.currentOTP ?? Observable.empty()
            }
            .subscribe(onNext: { [weak self] otp in
                if self?.checkOTP(otp) ?? false {
                    self?.viewModel.updatePassword()
                } else {
                    self?.viewModel.currentStage.accept(.three(false))
                }
            })

        let nextBtnTap = nextButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.nextDidTap)
                  
        let outsideCloseDidTap = outsideCloseButton.rx.tap
            .bind(to: viewModel.outsideCloseDidTap)

        disposeBag.insert(
            stageChanged,
            nextBtnTap,
            checkOtp,
            outsideCloseDidTap
        )
    }
    
}


//MARK: - Helper
extension VerificationViewController {
    func updateCurrentStageUI(stage: VerificationStageEnum) {
        switch stage {
        case .one:
            inputContainer.isHidden = false
            statusContainer.isHidden = true
            emailContainer.isHidden = false
            otpTextFieldView.isHidden = true
        case .two:
            inputContainer.isHidden = false
            statusContainer.isHidden = true
            emailContainer.isHidden = true
            otpTextFieldView.isHidden = false
        case .three(let isSuccess):
            if isSuccess {
                statusTitleLabel.text = "Successfully Change Password"
                statusMessageLabel.text = "Kindly login with your new password."

            } else {
                statusTitleLabel.text = "Unsuccessfully Change Password"
                statusMessageLabel.text = "Kindly try again."
            }
            updateLottieFile(isSuccess: isSuccess)
            inputContainer.isHidden = true
            statusContainer.isHidden = false
        }
    }
    
    func updateLottieFile(isSuccess: Bool) {
        let statusLottie: LinkPassword.Enum.LottieFileName = isSuccess ? .success : .fail
        animationView.animation = Animation.named(statusLottie.rawValue)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func checkOTP(_ otp: String) -> Bool {
        return otp == "0000"
    }

}

//MARK: - <VerificationViewType>
extension VerificationViewController: VerificationViewType {
    func routeBack() {
        self.dismiss(animated: true)
    }
    
    
}
