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
}

class CoreDataManager {
    
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
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
    
    func updatePassword(forUsername username: String, currentPassword: String, newPassword: String) -> Result<Void, Error> {
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
