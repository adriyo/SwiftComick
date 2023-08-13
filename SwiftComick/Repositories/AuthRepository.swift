//
// AuthRepository.swift
// SwiftComick
//
// Created by Adri Driyo on 05/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation
import FirebaseAuth

struct AuthRepository {
    
    func login(email: String, password: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            guard let user = authResult?.user else { return }
            let userResult = UserInfo(username: user.displayName ?? "Unknown", profilePictureURL: user.photoURL?.absoluteString)
            saveUser(email: email, displayName: userResult.username, photoURL: userResult.profilePictureURL)
            completion(.success(userResult))
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            guard let user = authResult?.user else { return }
            let userResult = UserInfo(username: user.displayName ?? "Unknown", profilePictureURL: user.photoURL?.absoluteString)
            saveUser(email: email, displayName: userResult.username, photoURL: userResult.profilePictureURL)
            completion(.success(userResult))
        }
    }
    
    func saveUser(email: String, displayName: String, photoURL: String?) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(displayName, forKey: "displayName")
        UserDefaults.standard.set(photoURL, forKey: "photoURL")
    }
    
}
