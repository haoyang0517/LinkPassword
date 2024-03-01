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
