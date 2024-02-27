//
//  CustomIconTextField.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

@IBDesignable
class CustomIconTextField: UITextField {

    @IBInspectable var leftIcon: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var iconWidth: CGFloat = 20
    @IBInspectable var iconPadding: CGFloat = 8

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += iconPadding
        return rect
    }

    private func updateView() {
        if let icon = leftIcon {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
            imageView.image = icon
            imageView.contentMode = .center

            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: iconWidth + iconPadding * 2, height: bounds.height))
            iconContainerView.addSubview(imageView)

            leftView = iconContainerView
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }

    // MARK: - Interface Builder

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }

}
