//
// LoginView.swift
// SwiftComick
//
// Created by Adri Driyo on 23/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

enum AlertType: String {
    case Loading
    case Error
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
       
    @StateObject private var viewModel: AuthViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func login() {
        viewModel.login(email: email, password: password)
    }
    
    private func register() {
        
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack(spacing: 20) {
                Button("Login", action: login)
                    .padding()
                    .foregroundColor(.white)
                    .background(colorScheme == .dark ? Color.blue : Color.black)
                    .cornerRadius(8)
                
                Button("Register", action: register)
                    .padding()
                    .foregroundColor(.white)
                    .background(colorScheme == .dark ? Color.green : Color.orange)
                    .cornerRadius(8)
            }
            .padding()
            
        }
        .padding()
        .preferredColorScheme(colorScheme)
        .alert(isPresented: $viewModel.showAlert) {
            if viewModel.alertType == .Error {
                return Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Loading"), message: Text("Please wait..."), dismissButton: .none)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AuthViewModel(authRepository: AuthRepository())).preferredColorScheme(.dark)
    }
}
