//
//  DropDownTextField.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

class DropdownTextField: UITextField, UITextFieldDelegate {
    // Callback function type
    typealias DropdownCallback = () -> Void
    
    // Callback closure
    var dropdownCallback: DropdownCallback?
    
    // Custom initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // Override textRect(forBounds:) to adjust the inset between the border and the text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
    }

    // Override editingRect(forBounds:) to adjust the inset while editing
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
    }

    // Function to set up UI elements
    private func setupUI() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.2).cgColor
        self.layer.cornerRadius = 5
        self.font = LinkPassword.Fonts.soraRegular(size: 16)
        self.textColor = LinkPassword.Colors.PrimaryText

        // Set the right view to a dropdown icon
        let dropdownImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        dropdownImageView.tintColor = LinkPassword.Colors.PrimaryText
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        dropdownImageView.addGestureRecognizer(tapGesture)
        dropdownImageView.isUserInteractionEnabled = true
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightView.addSubview(dropdownImageView)
        dropdownImageView.center = rightView.center
        self.rightView = rightView
        self.rightViewMode = .always
        
        // Set the delegate to self
        self.delegate = self
        
        // Add tap gesture to detect when the text field is tapped
        let textFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        self.addGestureRecognizer(textFieldTapGesture)

    }
    
    // Function to handle dropdown icon tap
    @objc private func dropdownTapped() {
        // Call the callback function if set
        dropdownCallback?()
    }
    
    // Function to handle text field tap
    @objc private func textFieldTapped() {
        // Call the callback function if set
        dropdownCallback?()
    }
    
    // Override becomeFirstResponder to handle when the text field becomes the first responder
    override func becomeFirstResponder() -> Bool {
        // Call the callback function if set
        dropdownCallback?()
        return false  // Do not become first responder
    }
    
    // UITextFieldDelegate method to make the text field non-editable
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }

}
