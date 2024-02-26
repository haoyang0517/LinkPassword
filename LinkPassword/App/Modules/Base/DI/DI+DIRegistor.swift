//
//  DI+DIRegistor.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation

extension DI : DIRegistor {
    static func register() {
        Constant.register()
        Model.register()
        Helper.register()
        Service.register()
        ViewPairs.register() // Combine ViewController and ViewModel
    }
}
