//
//  UIButton+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension UIButton {
    
    func dropShadow(radius: CGFloat = 16){
        self.layer.shadowOffset = CGSize(width: 2, height: 9.5)
        self.layer.shadowColor = UIColor(hexString: "#4461F226")?.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    func removeShadow(){
        self.layer.shadowOpacity = 0
    }
}
