//
//  HomeViewModel.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 28/02/2024.
//

import Foundation
import RxSwift
import RxCocoa
import SwifterSwift

final class HomeViewModel: BaseViewModel {
    
    //MARK: - Inputs
    private let categorySubject = BehaviorSubject<[PasswordCategory]>(value: [])
    let selectedCategorySubject = PublishSubject<PasswordCategory>()

    var categories: Observable<[PasswordCategory]> {
        return categorySubject.asObservable()
    }
    var selectedCategory: Observable<PasswordCategory> {
        return selectedCategorySubject.asObservable()
    }

    let addDidTap = PublishSubject<Void>()


    //MARK: - Outputs
    
    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: HomeViewType? = nil
    
    //MARK: - Initializer
    override init() {
        super.init()
        
        categorySubject.onNext(PasswordCategory.allCases)
        selectedCategorySubject.onNext(.all)
    }
    
    override func dispose() {
        super.dispose()
    }
    
    //MARK: - Transform
    override func transform() {
        super.transform()
        
        let addDidTap = addDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToAdd()
            })

                
        disposeBag.insert(
        )
    }
}

extension HomeViewModel {
    func selectCategory(at indexPath: IndexPath) {
        
        categorySubject
            .take(1) // Take the latest emitted value from the observable
            .subscribe(onNext: { [weak self] items in
                guard indexPath.row < items.count else { return }
                let selectedItem = items[indexPath.row]
                self?.selectedCategorySubject.onNext(selectedItem)
            })
            .disposed(by: disposeBag)

    }

}
