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

struct AuthRepository {
    
    func login(email: String, password: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(UserInfo(username: "Rudy", profilePictureURL: "https://s.hs-data.com/bilder/spieler/gross/13029.jpg")))
        }
    }
    
}
