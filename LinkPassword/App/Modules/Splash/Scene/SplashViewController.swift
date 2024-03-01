//
//  SplashViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie
import SwifterSwift

class SplashViewController: BaseViewController<SplashViewModel> {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lottieView: AnimationView!
    
    //MARK: - Constants
    
    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SplashViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        let splashLottie: LinkPassword.Enum.LottieFileName = .splash
        lottieView.animation = Animation.named(splashLottie.rawValue)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.play { [weak self] (_) in
            guard let self = self else { return }
            self.checkIsLoggedIn()
        }
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
    }
}


//MARK: - Helper
extension SplashViewController {
    func checkIsLoggedIn(){
        if UserDefaults.isLoggedIn {
            let screen = UIStoryboard(name: "MainTabViewController", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewController")
            SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
        } else {
            let screen = DI.resolver.resolve(SplashMenuViewControllerType.self)!
            let nav = BaseNavigationController(rootViewController: screen)
            SwifterSwift.sharedApplication.keyWindow?.rootViewController = nav
        }

    }
}

//MARK: - <SplashViewType>
extension SplashViewController: SplashViewType {
    
}
