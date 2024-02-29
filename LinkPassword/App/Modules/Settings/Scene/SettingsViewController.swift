//
//  SettingsViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift

class SettingsViewController: BaseViewController<SettingsViewModel> {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Constants
    let settingsTableViewCellIdentifier: String = "SettingsTableViewCell"

    //MARK: - Vars

    //MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(SettingsViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        tableView.register(UINib(nibName: settingsTableViewCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: settingsTableViewCellIdentifier)

    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
        viewModel.startExit = rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        let settingDelegate = tableView.rx.setDelegate(self)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<SettingSectionEntity>(
            configureCell: { (_, tableView, indexPath, item) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: self.settingsTableViewCellIdentifier, for: indexPath) as? SettingsTableViewCell else {
                    return UITableViewCell()
                }
                cell.setupSettingCell(setting: item)
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].identity
            }
        )

        let settingList = viewModel.settingSection
            .bind(to: tableView.rx.items(dataSource: dataSource))

        let settingSelected = tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.viewModel.selectSetting(at: indexPath)
            }

        // Subscribe to the selectedIndexPath observable to do action
        let selectedSettingTrigger = viewModel.selectedSetting
            .subscribe(onNext: { [weak self] setting in
                self?.settingAction(setting: setting)
            })
        
        disposeBag.insert(
            settingDelegate,
            settingList,
            settingSelected,
            selectedSettingTrigger
        )

    }
}


//MARK: - Helper
extension SettingsViewController {
    func settingAction(setting: SettingOptionEntity){
        // this sample only navigation got function
        if setting.isShowNavigationIcon != nil {
            switch setting.title {
            case "Change Password":
                routeToChangePassword()
            case "Log Out":
                logoutAction()
            default:
                break
            }
        }
    }
    
    func routeToChangePassword(){
        let screen = DI.resolver.resolve(ChangePasswordViewControllerType.self)!
        self.navigationController?.pushViewController(screen)
    }
    
    func logoutAction(){
        // Set login status to true
        UserDefaults.isLoggedIn = false
        // Save username
        UserDefaults.username = ""

        let screen = DI.resolver.resolve(SplashMenuViewControllerType.self)!
        let nav = BaseNavigationController(rootViewController: screen)
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = nav

    }
}

//MARK: - <SettingsViewType>
extension SettingsViewController: SettingsViewType {
    
}

//MARK: UITableView Delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
