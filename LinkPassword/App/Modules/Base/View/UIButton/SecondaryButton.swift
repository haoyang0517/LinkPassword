//
//  SecondaryButton.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
class SecondaryButton: UIButton {
    
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
//            self.backgroundColor = isEnabled ? .primaryBtnColor : .primaryBtnColor
//        }
//    }
//
//    override var isHighlighted: Bool {
//        didSet {
//            super.isHighlighted = isHighlighted
//            backgroundColor = isHighlighted ? .primaryBtnColor : .primaryBtnColor
//        }
//    }
    
    private func commonInit() {
        self.backgroundColor = LinkPassword.Colors.SecondaryBtnColor
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        self.clipsToBounds = true
        self.layer.cornerRadius = 7.91
        self.dropShadow()
        self.titleLabel?.font = LinkPassword.Fonts.sfProTextRegular(size: 15.02)
    }
}
