//
//  CustomTextField.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    @IBInspectable var isBeginEdit = false {
        didSet {
            self.layer.borderColor = isBeginEdit ? LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.4).cgColor : LinkPassword.Colors.TextFieldBorder.withAlphaComponent(0.2).cgColor
            
        }
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
    
    // Override textRect(forBounds:) to adjust the inset between the border and the text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
    }

    // Override editingRect(forBounds:) to adjust the inset while editing
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18))
    }

}
