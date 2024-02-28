//
//  PrimaryButton.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
//    override var isEnabled: Bool {
//        didSet {
//            self.backgroundColor = isEnabled ? .PrimaryBtnColor : .PrimaryBtnColor
//        }
//    }
//    
//    override var isHighlighted: Bool {
//        didSet {
//            super.isHighlighted = isHighlighted
//            backgroundColor = isHighlighted ? .PrimaryBtnColor : .PrimaryBtnColor
//        }
//    }
    
    private func commonInit() {
        self.backgroundColor = LinkPassword.Colors.PrimaryBtnColor
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        self.clipsToBounds = true
        self.layer.cornerRadius = 7.91
        self.dropShadow()
        self.titleLabel?.font = LinkPassword.Fonts.sfProTextRegular(size: 15.02)
    }
}
