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
import CoreData

final class HomeViewModel: BaseViewModel {
    
    //MARK: - Inputs
    let categorySubject = BehaviorSubject<[PasswordCategory]>(value: PasswordCategory.allCases)
    let selectedCategorySubject = BehaviorSubject<PasswordCategory>(value: .all)
    let passwordsSubject = BehaviorSubject<[Password]>(value: [])
    let addDidTap = PublishSubject<Void>()

    //MARK: - Outputs
    var categories: Observable<[PasswordCategory]> {
        return categorySubject.asObservable()
    }
    var selectedCategory: Observable<PasswordCategory> {
        return selectedCategorySubject.asObservable()
    }
    var filteredPassword: Observable<[Password]> {
        return passwordsSubject.asObservable()
    }

    //MARK: - Dependencies
    
    //MARK: - States
    public weak var view: HomeViewType? = nil
    
    //MARK: - Initializer
    override init() {
        super.init()
        
        passwordsSubject.onNext(fetchPasswordsForCurrentUser(selectedCategory: .all))
    }
    
    override func dispose() {
        super.dispose()
    }
    
    //MARK: - Transform
    override func transform() {
        super.transform()
        
        let initialLoadData = Observable.combineLatest(
            startLoad.asObservable(),
            selectedCategory
        )
        .subscribe(onNext: { [weak self] (_, selectedCategory) in
            self?.passwordsSubject.onNext(self?.fetchPasswordsForCurrentUser(selectedCategory: selectedCategory) ?? [])
        })
        
        let addDidTap = addDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToAdd()
            })
                        
        disposeBag.insert(
            initialLoadData,
            addDidTap
        )
    }
}

// MARK: - Collectionview
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

// MARK: - Core Data load user data
extension HomeViewModel {
    func fetchPasswordsForCurrentUser(selectedCategory: PasswordCategory?) -> [Password] {  
        return CoreDataManager.shared.fetchPasswordsForCurrentUser(selectedCategory: selectedCategory)
    }


    func handleDeleteAction(at indexPath: IndexPath) {
        do {
            var currentPasswords = try passwordsSubject.value()

            // Ensure indexPath is within bounds
            guard indexPath.row < currentPasswords.count else {
                return
            }

            let passwordToDelete = currentPasswords[indexPath.row]

            // Delete the password using CoreDataManager
            let result = CoreDataManager.shared.deletePassword(passwordToDelete)

            switch result {
            case .success:
                // Update UI by removing the item from the observable
                currentPasswords.remove(at: indexPath.row)

                DispatchQueue.main.async {
                    self.passwordsSubject.onNext(currentPasswords)
                }
            case .failure(let error):
                print("Error deleting password: \(error)")
            }
        } catch {
            print("Error getting current passwords: \(error)")
        }
    }

}
