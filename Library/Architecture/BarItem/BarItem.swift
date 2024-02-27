//
//  BarItem.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

class BarItem: Equatable {
    var id: String
    
    var closure: ((UIViewController)->())? = nil
    
    weak var viewController: UIViewController? = nil
    
    static func == (lhs: BarItem, rhs: BarItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(id: String) {
        self.id = id
    }
    
    func createBarButtonItem() -> UIBarButtonItem? {
        return nil
    }
    
    @objc func performAction(sender: Any?) {
        if let viewController = viewController {
            closure?(viewController)
        }
    }
}

