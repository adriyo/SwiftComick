//
// MainTabBarView.swift
// SwiftComick
//
// Created by Adri Driyo on 22/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

class TabStateHandler: ObservableObject {
    @Published var tabSelected: Tab = .Home {
        didSet {
            if oldValue == tabSelected && tabSelected == .Home {
                moveFirstTabToTop.toggle()
            }
        }
    }
    @Published var moveFirstTabToTop: Bool = false
    @Published var isToolbarHidden = false
    
    func handleTabChange(_ selectedTab: Tab) {
        tabSelected = selectedTab
        isToolbarHidden = selectedTab == .Activity || selectedTab == .Settings
        
        print("tabSelected: \(selectedTab)")
        
        print("isToolbarHidden: \(isToolbarHidden)")
    }
}

struct MainScreenView: View {
    
    @StateObject private var tabStateHandler: TabStateHandler = TabStateHandler()
    @ObservedObject private var viewModel: AuthViewModel
    
    init() {
        let authRepository = AuthRepository()
        self.viewModel = AuthViewModel(authRepository: authRepository)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                BottomTabView(tabStateHandler: tabStateHandler)
                    .toolbar {
                        ToolbarView(tabSelected: $tabStateHandler.tabSelected, viewModel: viewModel)
                    }
            }
        }
        .environmentObject(tabStateHandler)
    }
}

struct ToolbarView: ToolbarContent {
    @Binding var tabSelected: Tab
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if tabSelected == .Home {
                Image("unicorn-64")
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                Text(tabSelected.rawValue)
            }
        }
        
        ToolbarItem(placement: .principal) {
            SearchView(onSearchFieldIsFocused:  { isFocused in
                print("isFocused \(isFocused)")
            })
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            if let user = viewModel.user {
                AsyncImage(url: URL(string: user.profilePictureURL)) { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 1)
                        )
                } placeholder: {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                }
            } else {
                NavigationLink(destination: LoginView(viewModel: viewModel)) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            
        }
    }
}

struct SearchView: View {
    @State private var searchText = ""
    
    var onSearchFieldIsFocused : (Bool) -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(height: 40)
            
            TextField("Search", text: $searchText)
                .padding(.all, 10)
                .simultaneousGesture(TapGesture().onEnded {
                    print("Textfield pressed")
                })
        }
        .padding(.horizontal)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
