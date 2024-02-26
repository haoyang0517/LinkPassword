//
//  ViewControllerCycleImplType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation

@objc protocol ViewControllerCycleImplType {
    @objc var viewWillAppearCount:Int { set get }
    @objc var viewDidAppearCount:Int { set get }
    @objc var isViewVisible: Bool { set get }
}
