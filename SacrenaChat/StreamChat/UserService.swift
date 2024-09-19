//
//  UserService.swift
//  SacrenaChat
//

import Foundation
import StreamChat

protocol UserService {
    func createUser(completion: @escaping (Bool) -> ())
}

class StreamUserService: UserService {
    private let userInfo = Constants.User.userInfoAlice
    
    func createUser(completion: @escaping (Bool) -> ()) {
        ChatClient.shared.connectUser(userInfo: userInfo, token: Constants.API.nonExpiringToken) { error in
            if let error = error {
                print("Error connecting user: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("User connected successfully.")
            completion(true)
        }
    }
}
