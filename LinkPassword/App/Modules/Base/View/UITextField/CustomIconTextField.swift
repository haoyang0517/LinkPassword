//
//  CustomIconTextField.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift

@IBDesignable
class CustomIconTextField: UITextField {

    @IBInspectable var leftIcon: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var rightSecureButton: Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable var iconWidth: CGFloat = 20
    @IBInspectable var iconPadding: CGFloat = 8

    // MARK: - Placeholder
    @IBInspectable var placeholderColor: UIColor = LinkPassword.Colors.SecondaryText
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    private func updatePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }

    
    @IBInspectable var isBeginEdit = false {
        didSet {
            self.layer.borderColor = isBeginEdit ? LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.4).cgColor : LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.2).cgColor
            
        }
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += iconPadding
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        if rightSecureButton {
            let rightPadding: CGFloat = 8
            return CGRect(x: bounds.width - bounds.height - rightPadding, y: 0, width: bounds.height, height: bounds.height)
        }
        return super.rightViewRect(forBounds: bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.2).cgColor
        self.layer.cornerRadius = 5
        self.font = LinkPassword.Fonts.soraRegular(size: 16)
        self.textColor = LinkPassword.Colors.PrimaryText
        
        self.rx.controlEvent(.editingDidBegin).bind {
            self.isBeginEdit = true
        }.disposed(by: disposeBag)
        
        self.rx.controlEvent(.editingDidEnd).bind {
            self.isBeginEdit = false
        }.disposed(by: disposeBag)

    }

    private func updateView() {
        // Left Icon
        if let icon = leftIcon {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: bounds.height))
            imageView.image = icon
            imageView.contentMode = .center

            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: iconWidth + iconPadding * 2, height: bounds.height))
            iconContainerView.addSubview(imageView)
            imageView.center = iconContainerView.center

            leftView = iconContainerView
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }

        // Right Secure Button
        if rightSecureButton {
            let secureButton = UIButton(type: .custom)
            secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
            secureButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
            secureButton.tintColor = UIColor(hexString: "#96A7AF")
            secureButton.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
            secureButton.addTarget(self, action: #selector(toggleSecureText), for: .touchUpInside)

            rightView = secureButton
            rightViewMode = .always
        } else {
            rightView = nil
            rightViewMode = .never
        }

    }

    @objc private func toggleSecureText(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected = isSecureTextEntry
    }



    // MARK: - Interface Builder

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }

}
