//
// AuthViewModel.swift
// SwiftComick
//
// Created by Adri Driyo on 05/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

class AuthViewModel: ObservableObject {
    
    private let authRepository: AuthRepository
    @Published var isLoggedIn: Bool = false
    @Published var user: UserInfo?
    @Published var showAlert: Bool = false
    @Published var alertType: AlertType = .Error
    @Published var errorMessage: String = ""
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private func isValidEmail(email: String) -> Bool {
        return !email.isEmpty
    }
    
    private func isValidPassword(password: String) -> Bool {
        return password.count >= 6
    }
    
    func login(email: String, password: String) {
        if !isValidEmail(email: email) || !isValidPassword(password: password) {
            errorMessage = "Invalid email or password."
            alertType = .Error
            showAlert = true
            return
        }
        
        alertType = .Loading
        showAlert = true
        
        authRepository.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.showAlert = false
                self?.isLoggedIn = true
                self?.user = user
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
}
