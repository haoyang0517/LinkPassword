//
//  UIViewController+RxBarItemsViewType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    func leftBarButtonItem(_ barItem: BarItem) -> Driver<Void> {
        let index = base.leftBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.leftBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem.rx.tap.asDriver()
            }
        }
        return .empty()
    }
    func rightBarButtonItem(_ barItem: BarItem) -> Driver<Void> {
        let index = base.rightBarItems.firstIndex(where: { $0 == barItem })
        if let index = index, let buttonItems = base.navigationItem.rightBarButtonItems {
            if index < buttonItems.count {
                let buttonItem = buttonItems[index]
                return buttonItem.rx.tap.asDriver()
            }
        }
        return .empty()
    }
}
