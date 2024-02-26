//
//  ViewType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewType {
    associatedtype VM: ViewModelType
    var viewModel: VM! { set get }
}
