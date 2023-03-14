//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by Octav Radulian on 14.03.2023.
//

import Foundation
import FirebaseDatabase
//we will create a public api that can read and write on our database
//this object will read and write on firebase database
//it is separate because otherwise we will have the same code on each VC

//we want this class to be a singleton for easy read and write acess
//and is marked as final

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
//MARK: - Account Management
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        //we add a completion because the function to get data out of the databse is async
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
    ///Insert new user to database
    public func insertUser(with user: ChatAppUser) {
        //the unique key for users is email
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
        ])
    }
    
}


struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    //let profilePictureUrl: String
}
