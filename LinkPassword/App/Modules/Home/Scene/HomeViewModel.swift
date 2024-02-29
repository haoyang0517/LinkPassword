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
    let categorySubject = BehaviorSubject<[PasswordCategory]>(value: [])
    let selectedCategorySubject = PublishSubject<PasswordCategory>()
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
        
        categorySubject.onNext(PasswordCategory.allCases)
        selectedCategorySubject.onNext(.all)
    }
    
    override func dispose() {
        super.dispose()
    }
    
    //MARK: - Transform
    override func transform() {
        super.transform()
        
        let loadData = startLoad
            .do(onNext: { [weak self] _ in
                self?.passwordsSubject.onNext(self?.fetchPasswordsForCurrentUser() ?? [])
            })
                        
        let addDidTap = addDidTap
            .subscribe(onNext: { [weak self] _ in
                self?.view?.routeToAdd()
            })
                        
        disposeBag.insert(
            loadData.drive(),
//            setDefaultCategory,
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
    func fetchPasswordsForCurrentUser() -> [Password]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Password>(entityName: "Password")
        
        fetchRequest.predicate = NSPredicate(format: "user.username == %@ OR user.email == %@", UserDefaults.username ?? "", UserDefaults.username ?? "")

        do {
            let passwords = try context.fetch(fetchRequest)
            print("Passwords for user \(passwords)")
            return passwords
        } catch {
            print("Error fetching contacts: \(error.localizedDescription)")
            return nil
        }
    }


    func handleDeleteAction(at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        do {
            var currentPasswords = try passwordsSubject.value()
            
            // Ensure indexPath is within bounds
            guard indexPath.row < currentPasswords.count else {
                return
            }
            
            let passwordToDelete = currentPasswords[indexPath.row]
            
            // Delete the password from Core Data
            let context = appDelegate.persistentContainer.viewContext
            context.delete(passwordToDelete)
            
            do {
                try context.save()
                
                // Update UI by removing the item from the observable
                currentPasswords.remove(at: indexPath.row)

                // Make sure to dispatch UI updates on the main thread
                DispatchQueue.main.async {
                    self.passwordsSubject.onNext(currentPasswords)
                }

            } catch {
                print("Error saving context after deletion: \(error)")
            }
        } catch {
            print("Error getting current passwords: \(error)")
        }
    }

}
