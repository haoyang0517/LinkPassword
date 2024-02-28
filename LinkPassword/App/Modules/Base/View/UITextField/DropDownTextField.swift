//
//  DropDownTextField.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit

class DropdownTextField: UITextField {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
        dropdownImageView.addGestureRecognizer(tapGesture)
        dropdownImageView.isUserInteractionEnabled = true
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightView.addSubview(dropdownImageView)
        dropdownImageView.center = rightView.center
        self.rightView = rightView
        self.rightViewMode = .always
        
        // Disable user editing
        self.isUserInteractionEnabled = false
    }
    
    // Function to handle dropdown icon tap
    @objc private func dropdownTapped() {
        // Call the callback function if set
        dropdownCallback?()
    }
}
