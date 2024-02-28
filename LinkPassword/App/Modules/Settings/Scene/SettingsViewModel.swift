//
//  SettingsViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class SettingsViewModel: BaseViewModel {
    
    //MARK: - Inputs
    private let settingSectionSubject = BehaviorSubject<[SettingSectionEntity]>(value: [])
    var settingSection: Observable<[SettingSectionEntity]> {
        return settingSectionSubject.asObservable()
    }
    
    let selectedSettingSubject = PublishSubject<SettingOptionEntity>()
    var selectedSetting: Observable<SettingOptionEntity> {
        return selectedSettingSubject.asObservable()
    }
    
    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: SettingsViewType? = nil
    
    //MARK: - Constant
    let staticSectionData: [SettingSectionEntity] = [
        SettingSectionEntity(title: "Account", option: [
            SettingOptionEntity(title:"Username",
                                subTitle: "",
                                value: "temp username",
                                isShowNavigationIcon: nil
                               ),
            SettingOptionEntity(title:"Change Password",
                                subTitle: "",
                                value: "",
                                isShowNavigationIcon: LinkPassword.Images.settings_navi
                               )
        ]),
        SettingSectionEntity(title: "Other", option: [
            SettingOptionEntity(title:"Updates",
                                subTitle: "Jan 31, 2023",
                                value: "Update",
                                isShowNavigationIcon: nil
                               ),
            SettingOptionEntity(title:"Share",
                                subTitle: "",
                                value: "Invite your friends",
                                isShowNavigationIcon: nil
                               ),
            SettingOptionEntity(title:"Language",
                                subTitle: "",
                                value: "English",
                                isShowNavigationIcon: nil
                               )

        ]),
        SettingSectionEntity(title: "", option: [
            SettingOptionEntity(title:"Log Out",
                                subTitle: "",
                                value: "",
                                isShowNavigationIcon: LinkPassword.Images.settings_logout
                               ),

        ])
    ]

    //MARK: - Initializer
    override init() {
        super.init()
        settingSectionSubject.onNext(staticSectionData)
    }
    
    override func dispose() {
        super.dispose()
    }
    
    //MARK: - Transform
    override func transform() {
        super.transform()
        
                
        disposeBag.insert(
            
        )
    }
}

extension SettingsViewModel {
    func selectSetting(at indexPath: IndexPath) {
        
        settingSectionSubject
            .take(1) // Take the latest emitted value from the observable
            .subscribe(onNext: { [weak self] items in
                guard indexPath.row < items.count else { return }
                let selectedItem = items[indexPath.section].option[indexPath.row]
                self?.selectedSettingSubject.onNext(selectedItem)
            })
            .disposed(by: disposeBag)

    }

}
