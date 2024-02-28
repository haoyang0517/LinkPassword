//
//  LinkPasswordFont.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import Foundation
import UIKit

extension LinkPassword.Fonts {
    static let sfProTextRegular = "SFProText-Regular"
    static let soraRegular = "Sora-Regular"
    static let soraSemiBold = "Sora-SemiBold"

    static func sfProTextRegular(size: CGFloat) -> UIFont {
        return UIFont(name: sfProTextRegular, size: size)!
    }
    
    static func soraRegular(size: CGFloat) -> UIFont {
        return UIFont(name: soraRegular, size: size)!
    }

    static func soraSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: soraSemiBold, size: size)!
    }


}

