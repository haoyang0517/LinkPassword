//
//  SettingsEnum.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import UIKit
import RxDataSources
import Differentiator

enum SettingsCategory: String, CaseIterable {
    case username = "Username"
    case changePassword = "Change Password"
    case updates = "Updates"
    case share = "Share"
    case language = "Language"
    case loguut = "Log Out"

}

struct SettingSectionEntity {
    var title: String
    var option: [SettingOptionEntity]
}

extension SettingSectionEntity: AnimatableSectionModelType {
    typealias Item = SettingOptionEntity

    var identity: String {
        return title
    }

    var items: [SettingOptionEntity] {
        return option
    }

    init(original: SettingSectionEntity, items: [SettingOptionEntity]) {
        self = original
        self.option = items
    }
}

struct SettingOptionEntity {
    var identity: String {
        return title
    }
    
    var title: String
    var subTitle: String
    var value: String
    var isShowNavigationIcon: UIImage?
}

extension SettingOptionEntity: IdentifiableType, Equatable {
    static func == (lhs: SettingOptionEntity, rhs: SettingOptionEntity) -> Bool {
        return lhs.title == rhs.title
    }
}
