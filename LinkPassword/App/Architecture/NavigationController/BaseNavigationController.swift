//
//  BaseNavigationController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit

class BaseNavigationController: UINavigationController, BaseViewType, UINavigationControllerDelegate {
    var disposeOnWillRemoveFromParent: Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    func commonInit() {
        self.delegate = self
    }
    
    override func dispose() {
        super.dispose()
    }
    
    deinit {

    }
//    //MARK: <UINavigationControllerDelegate>
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if self.presentingViewController != nil {
//            if self.viewControllers.first == viewController {
//                if viewController.leftBarItem == nil {
//                    viewController.leftBarItem = .close()
//                }
//            } else {
//                if viewController.leftBarItem == nil {
//                    viewController.leftBarItem = .back()
//                }
//            }
//        } else {
//            if self.viewControllers.first == viewController {
//                if viewController.leftBarItem == nil {
//                    viewController.leftBarItem = nil
//                }
//            } else {
//                if viewController.leftBarItem == nil {
//                    viewController.leftBarItem = .back()
//                }
//            }
//        }
//        if let child = (viewController as? BaseNavigationChildViewController) {
//            if let willShow = child.willShowInNavigationController {
//                willShow(navigationController, animated)
//            }
//            if let getIsNavigationBarHidden = child.isNavigationBarHidden {
//                self.isNavigationBarHidden = getIsNavigationBarHidden
//            }
//        }
//    }

}
