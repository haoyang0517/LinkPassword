//
//  OTPTextFieldView.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class OTPTextFieldView: UIView, UITextFieldDelegate {
    
    private var textFields: [UITextField] = []
    
    private var currentOTPRelay = BehaviorRelay<String>(value: "")

    var currentOTP: Observable<String> {
        return currentOTPRelay.asObservable()
    }

    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextFields()
    }
    
    private func setupTextFields() {
        let textFieldWidth: CGFloat = 50
        let spacing: CGFloat = 18
        
        for index in 0..<4 {
            let textField = UITextField()
            textField.tag = index
            textField.delegate = self
            textField.textAlignment = .center
            textField.backgroundColor = .white
            textField.layer.borderColor = LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.2).cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5

            textField.textColor = LinkPassword.Colors.PrimaryText
            textField.font = LinkPassword.Fonts.soraRegular(size: 16)
            textField.keyboardType = .numberPad
            textField.frame = CGRect(x: CGFloat(index) * (textFieldWidth + spacing), y: 0, width: textFieldWidth, height: textFieldWidth)
            addSubview(textField)
            
            textFields.append(textField)
            
            // Add target to move to the next field when a character is typed
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            // Use RxSwift to bind the text field changes to the currentOTPRelay
            textField.rx.text.orEmpty
                .subscribe(onNext: { [weak self] text in
                    // Update the currentOTPRelay with the concatenated OTP value
                    guard let self = self else { return }
                    var otpValue = self.currentOTPRelay.value
                    otpValue = self.updateOTPValue(otpValue, atIndex: index, withString: text)
                    self.currentOTPRelay.accept(otpValue)
                })
                .disposed(by: disposeBag)

            textFields.append(textField)

        }
    }
    
    private func updateOTPValue(_ otpValue: String, atIndex index: Int, withString string: String) -> String {
        var otpArray = Array(otpValue)

        // Ensure the otpArray has enough elements before modifying a specific index
        while otpArray.count <= index {
            otpArray.append("_") // Use any default character for the empty slots
        }

        otpArray[index] = string.isEmpty ? "_" : string.first!

        return String(otpArray)
    }

    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let nextTag = textField.tag + 1
        
        // Move to the next field when a character is typed
        if nextTag < textFields.count, let nextTextField = viewWithTag(nextTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        }
        
        // Notify when all text fields are filled
        if textField.tag == textFields.count - 1, let text = textField.text, text.count == 1 {
            // Notify or handle completion here
            print("OTP entered: \(textFields.map { $0.text ?? "" }.joined())")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, !text.isEmpty, !string.isEmpty {
            // Replace the existing text with the new character
            textField.text = string
            return false  // Prevent the default behavior of the text field
        } else if string.isEmpty && textField.text?.isEmpty == true {
            // Move to the previous field when backspace is pressed and the current field is empty
            let previousTag = textField.tag - 1
            if previousTag >= 0, let previousTextField = viewWithTag(previousTag) as? UITextField {
                previousTextField.becomeFirstResponder()
            }
        }
        return true
    }
}
