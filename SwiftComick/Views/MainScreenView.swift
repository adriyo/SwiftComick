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
    @StateObject var tabStateHandler: TabStateHandler = TabStateHandler()
    
    var body: some View {
        NavigationView {
            VStack {
                BottomTabView(tabStateHandler: tabStateHandler)
                    .toolbar {
                        if !tabStateHandler.isToolbarHidden {
                            ToolbarView(tabSelected: $tabStateHandler.tabSelected)
                        }
                    }
            }
        }
        .environmentObject(tabStateHandler)
    }
}

struct ToolbarView: ToolbarContent {
   @Binding var tabSelected: Tab
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
            NavigationLink(destination: LoginView()) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct SearchView: View {
    @FocusState private var searchFieldIsFocused: Bool
    @State private var searchText = ""
    
    var onSearchFieldIsFocused : (Bool) -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(height: 40)
            
            TextField("Search", text: $searchText)
                .padding(.all, 10)
                .focused($searchFieldIsFocused)
                .simultaneousGesture(TapGesture().onEnded {
                    print("Textfield pressed")
                })
        }
        .padding(.horizontal)
        .onChange(of: searchFieldIsFocused) { newValue in
            print("onChange \(newValue)")
            onSearchFieldIsFocused(newValue)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
