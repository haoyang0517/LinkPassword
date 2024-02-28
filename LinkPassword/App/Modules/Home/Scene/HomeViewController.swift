//
//  HomeViewController.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

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

    //MARK: - Vars
    
    //MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(HomeViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()

        titleLabel.font = LinkPassword.Fonts.soraSemiBold(size: 32)
        categoryTitleLabel.text = "Categories"
        categoryTitleLabel.font = LinkPassword.Fonts.soraRegular(size: 16)
        categoryTitleLabel.textColor = LinkPassword.Colors.SecondaryText
        categoryCollectionView.register(
            UINib(nibName: categoryFilterCellIdentifier, bundle: Bundle.main),
            forCellWithReuseIdentifier: categoryFilterCellIdentifier
        )

    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        
        viewModel.view = self
        viewModel.startLoad = self.rx.viewDidLoad
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

        // Bind item selection to the ViewModel
        let categorySelected = categoryCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.viewModel.selectCategory(at: indexPath)
            }

        // Subscribe to the selectedIndexPath observable to update cell appearance
        let selectedCategoryUpdated = viewModel.selectedCategory
            .subscribe(onNext: { [weak self] categorySelected in
                self?.updateCellAppearance(for: categorySelected)
            })
        
        let addBtnDidTap = addButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.addDidTap)



        disposeBag.insert(
            categoryDelegate,
            categoryList,
            categorySelected,
            selectedCategoryUpdated,
            addBtnDidTap
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
            if let cellIndexPath = categoryCollectionView.indexPath(for: collectionViewCell), collectionViewCell.titleLabel.text == categorySelected.rawValue  {
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
}

//MARK: UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.width - 20 ) / 4
        let cellHeight = collectionView.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
