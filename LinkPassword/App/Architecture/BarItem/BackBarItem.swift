//
//  BackBarItem.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit

extension BarItem {
    static func back(color: UIColor = .white, closure: ((UIViewController)->())? = BackBarItem.defaultClosure) -> BarItem {
        let ret = BackBarItem()
        ret.defaultColor = color
        ret.closure = closure
        return ret
    }
}

class BackBarItem: BarItem {
    static let defaultId = "back"
    
    var defaultColor: UIColor = UIColor.black
    
    class func defaultClosure(_ vc:UIViewController) {
        vc.popWithResult()
    }
    
    init() {
        super.init(id: BackBarItem.defaultId)
    }
    
    override func createBarButtonItem() -> UIBarButtonItem? {
        let image:UIImage
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "arrow.backward")!
        } else {
            image = UIImage(systemName: "arrow.backward")!
        }
        let item = UIBarButtonItem(image:image , style: .plain, target: self, action: #selector(self.performAction(sender:)))
        item.imageInsets = .zero
        item.tintColor = self.defaultColor
        
        return item
    }
}
