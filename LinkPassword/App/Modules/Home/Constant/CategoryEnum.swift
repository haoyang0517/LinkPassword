//
//  CategoryEnum.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import CoreData

enum PasswordCategory: String, CaseIterable {
    case all = "All"
    case login = "Login"
    case card = "Card"
    case others = "Others"
}
