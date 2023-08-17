//
// UserView.swift
// SwiftComick
//
// Created by Adri Driyo on 06/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

struct UserView: View {
    
    @State private var selectedTab: Int = 0
    @StateObject private var viewModel: AuthViewModel

    let tabs: [TabItem] = [
        .init(icon: Image(systemName: "info"), title: "Info"),
        .init(icon: Image(systemName: "person"), title: "Profile"),
        .init(icon: Image(systemName: "gear"), title: "Settings")
    ]
    
    
    init(viewModel: AuthViewModel) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // Tabs
                Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                
                // Views
                TabView(selection: $selectedTab,
                        content: {
                    DemoView()
                        .tag(0)
                    DemoView()
                        .tag(1)
                    DemoView()
                        .tag(2)
                })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: HStack {
                Button("Logout") {
                    viewModel.logout()
                }
            })
        }
    }
}

struct DemoView: View {
    var body: some View {
        Text("TEXT 1")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: AuthViewModel(authRepository: AuthRepository()))
    }
}
