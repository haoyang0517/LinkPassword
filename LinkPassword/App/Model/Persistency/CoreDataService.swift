//
//  CoreDataService.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case userNotFound
    case incorrectCurrentPassword
    case entityNotFound
}

class CoreDataManager {
    
    static let shared = CoreDataManager()

    private init() {

    }

    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access AppDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    func signup(username: String, email:String, password: String) -> Result<Void, Error> {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)

        if let userEntity = entity {
            let user = NSManagedObject(entity: userEntity, insertInto: context)
            user.setValue(username, forKey: "username")
            user.setValue(email, forKey: "email")
            user.setValue(password, forKey: "password")

            do {
                try context.save()

                // Success
                return .success(())

            } catch {
                return .failure(error)
            }
        }
        return .failure(CoreDataError.entityNotFound)

    }
    
    func signIn(identifier: String, password: String) -> Result<Bool, Error> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ OR email == %@", identifier, identifier)

        do {
            let users = try context.fetch(fetchRequest) as! [NSManagedObject]

            if let user = users.first, let storedPassword = user.value(forKey: "password") as? String {
                return .success(storedPassword == password)
            } else {
                return .failure(CoreDataError.userNotFound)
            }
        } catch {
            return .failure(error)
        }

    }
    
    func fetchPasswordsForCurrentUser(selectedCategory: PasswordCategory?) -> [Password] {
        let fetchRequest = NSFetchRequest<Password>(entityName: "Password")
        
        var predicates: [NSPredicate] = []
        predicates.append(NSPredicate(format: "user.username == %@ OR user.email == %@", UserDefaults.username ?? "", UserDefaults.username ?? ""))
        
        if let selectedCategory = selectedCategory, selectedCategory != .all {
            predicates.append(NSPredicate(format: "type == %@", selectedCategory.rawValue))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)

        do {
            let passwords = try context.fetch(fetchRequest)
            print("Passwords for user \(passwords)")
            return passwords
        } catch {
            print("Error fetching passwords: \(error.localizedDescription)")
            return []
        }
    }

    func deletePassword(_ password: Password) -> Result<Void, Error> {
        do {
            context.delete(password)
            try context.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func savePasswordForUser(type: PasswordCategory, webname: String, urls: String, username: String, email: String, password: String) -> Result<Void, Error> {
        guard let usernameToFetch = UserDefaults.username else {
            print("UserDefaults username is nil")
            return .failure(CoreDataError.userNotFound)
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ OR email == %@", usernameToFetch, usernameToFetch)

        do {
            let users = try context.fetch(fetchRequest)

            if let user = users.first {
                let newPassword = Password(context: context)
                newPassword.type = type.rawValue
                newPassword.webname = webname
                newPassword.urls = urls
                newPassword.username = username
                newPassword.email = email
                newPassword.password = password

                // Add the password to the user's passwords
                user.addToPasswords(newPassword)

                // Save the changes
                try context.save()

                return .success(())
            } else {
                print("User not found for username \(usernameToFetch)")
                return .failure(CoreDataError.userNotFound)
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return .failure(error)
        }
    }


    func checkCurrentPassword(forUsername username: String, currentPassword: String) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(fetchRequest)

            guard let user = users.first else {
                // User not found
                return .failure(CoreDataError.userNotFound)
            }

            // Check if the current password matches
            guard user.password == currentPassword else {
                // Current password doesn't match
                return .failure(CoreDataError.incorrectCurrentPassword)
            }

            // Current password match, proceed
            return .success(())
        } catch {
            // Handle errors and return failure result
            return .failure(error)
        }
    }
    
    func updatePassword(forUsername username: String, newPassword: String) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(fetchRequest)

            guard let user = users.first else {
                // User not found
                return .failure(CoreDataError.userNotFound)
            }

            // Update the password attribute
            user.password = newPassword

            // Save the context to persist the changes
            try context.save()

            // Operation successful
            return .success(())
        } catch {
            // Handle errors and return failure result
            return .failure(error)
        }
    }

}
