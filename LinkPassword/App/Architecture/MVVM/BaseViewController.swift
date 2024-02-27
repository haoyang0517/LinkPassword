//
//  BaseViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<VM> : UIViewController, BaseViewType, ViewType, BaseNavigationChildViewController where VM : (BaseViewModelType) {
    
    @Injected public var Defaults: UserDefaults
    
    //MARK: Variable
    var screenName: String = ""
    
    //MARK: State
    var disposeOnWillRemoveFromParent: Bool = true
    var viewModel: VM! {
        didSet {
            if let vm = viewModel {
                vm.disposed(by: disposeBag)
            }
        }
    }
    //MARK: View Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTransformInput()
        transform()
        subscribe()
        subscribeAnalytics()
        view.backgroundColor = LinkPassword.Colors.bgColor
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
//            navigationController?.navigationBar.setColors(background: N8.Colors.primaryRed, text: N8.Colors.primaryWhite)
//            navigationController?.navigationBar.tintColor = N8.Colors.primaryWhite
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: N8.Colors.primaryWhite]
            //Remove border
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func dispose() {
        super.dispose()
    }
    
    deinit {
    }
    //MARK: setupView
    func setupView() {
        
    }
    //MARK: transform
    func setupTransformInput() {
    }
    
    func transform() {
        viewModel.transform()
    }
    //MARK: subscribe
    func subscribe() {
        
    }
    func subscribeAnalytics() {
        viewModel.subscribeAnalytics()
    }

    //MARK: <SMSNavigationChildViewController>
    var isNavigationBarHidden: Bool {
        return false
    }
}
