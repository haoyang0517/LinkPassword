//
//  OTPTextFieldView.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import UIKit

class OTPTextFieldView: UIView, UITextFieldDelegate {
    
    private var textFields: [UITextField] = []
    
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
            textField.backgroundColor = .lightGray
            textField.textColor = .black
            textField.font = UIFont.systemFont(ofSize: 20)
            textField.isSecureTextEntry = true
            textField.keyboardType = .numberPad
            textField.frame = CGRect(x: CGFloat(index) * (textFieldWidth + spacing), y: 0, width: textFieldWidth, height: textFieldWidth)
            addSubview(textField)
            
            textFields.append(textField)
            
            // Add target to move to the next field when a character is typed
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
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
        if string.isEmpty && textField.text?.isEmpty == true {
            // Move to the previous field when backspace is pressed and the current field is empty
            let previousTag = textField.tag - 1
            if previousTag >= 0, let previousTextField = viewWithTag(previousTag) as? UITextField {
                previousTextField.becomeFirstResponder()
            }
        }
        return true
    }
}
