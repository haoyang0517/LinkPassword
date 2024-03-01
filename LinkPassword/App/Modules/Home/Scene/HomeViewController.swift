//
//  HomeViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class HomeViewController: BaseViewController<HomeViewModel> {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Constants
    let categoryFilterCellIdentifier: String = "CategoryFilterCollectionViewCell"
    let PasswordTableViewCellIdentifier: String = "PasswordTableViewCell"

    //MARK: - Vars
    
    //MARK: - Lifecycles
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeSpecial()
    }
    
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(HomeViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        
        titleLabel.text = "Welcome\n \(UserDefaults.username ?? "")!"
        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        categoryTitleLabel.text = "Categories"
        categoryTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 16)
        categoryTitleLabel.textColor = LinkPassword.Colors.SecondaryText
        
        categoryCollectionView.register(
            UINib(nibName: categoryFilterCellIdentifier, bundle: Bundle.main),
            forCellWithReuseIdentifier: categoryFilterCellIdentifier
        )
        tableView.register(UINib(nibName: PasswordTableViewCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: PasswordTableViewCellIdentifier)
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewWillAppear
        viewModel.startExit = self.rx.viewWillDisappear
    }
    
    override func subscribe() {
        super.subscribe()
        
        let categoryDelegate = categoryCollectionView.rx.setDelegate(self)
        let categoryList = viewModel.categories.bind(to: categoryCollectionView.rx.items(cellIdentifier: categoryFilterCellIdentifier)){ index, category, cell in
            if let filterCell = cell as? CategoryFilterCollectionViewCell {
                filterCell.setupView(title: category.rawValue)
            }
        }
        let categorySelected = categoryCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.viewModel.selectCategory(at: indexPath)
            }
        
        let pwDelegate = tableView.rx.setDelegate(self)
        let pwList = viewModel
            .passwordsSubject
            .bind(to: tableView.rx.items(cellIdentifier: PasswordTableViewCellIdentifier)) { [weak self]
                index, password, cell in
                let pwCell = cell as! PasswordTableViewCell
                pwCell.setupCell(pw: password)
                pwCell.rx.moreDidTap.map({
                    self?.routeToDiscoverPassword(password: password)
                })
                .drive().disposed(by: pwCell.disposeBag)
            }
        
        let addBtnDidTap = addButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.addDidTap)

        disposeBag.insert(
            categoryDelegate,
            categoryList,
            categorySelected,
            pwDelegate,
            pwList,
            addBtnDidTap
        )

    }
    
    func subscribeSpecial(){
        // Late subscribe due to cell isn't loaded
        // Subscribe to the selectedIndexPath observable to update cell appearance
        let selectedCategoryUpdated = viewModel.selectedCategory
            .subscribe(onNext: { [weak self] categorySelected in
                self?.updateCellAppearance(for: categorySelected)
            })
        disposeBag.insert(
            selectedCategoryUpdated
        )
    }
}


//MARK: - Helper
extension HomeViewController {
    private func updateCellAppearance(for categorySelected: PasswordCategory) {

        for cell in categoryCollectionView.visibleCells {
            guard let collectionViewCell = cell as? CategoryFilterCollectionViewCell else {
                return
            }
            if let _ = categoryCollectionView.indexPath(for: collectionViewCell), collectionViewCell.titleLabel.text == categorySelected.rawValue  {
                collectionViewCell.isSelected = true
            } else {
                collectionViewCell.isSelected = false
            }
        }
    }
}

//MARK: - <HomeViewType>
extension HomeViewController: HomeViewType {
    func routeToAdd() {
        let screen = DI.resolver.resolve(AddPasswordViewControllerType.self)!
        self.navigationController?.pushViewController(screen)
    }
    
    func routeToDiscoverPassword(password: Password){
        let screen = DI.resolver.resolve(DiscoverPasswordViewControllerType.self)!
        screen.modalPresentationStyle = .overFullScreen
        screen.modalTransitionStyle = .crossDissolve
        screen.password = password
        self.present(screen, animated: false, completion: nil)
    }
}

//MARK: UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.width - 20 ) / 4
        let cellHeight = collectionView.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

//MARK: UITableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.viewModel.handleDeleteAction(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "home_delete")
        deleteAction.backgroundColor = LinkPassword.Colors.BgColor
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // Disable full swipe

        return configuration
    }
    
}
