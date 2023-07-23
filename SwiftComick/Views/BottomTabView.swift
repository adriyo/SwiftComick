//
// BottomTabView.swift
// SwiftComick
//
// Created by Adri Driyo on 23/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

enum Tab: String {
    case Home
    case MyList
    case Ranking
    case Search
    case Activity
    case Settings
}

struct BottomTabView: View {

    @ObservedObject var tabStateHandler: TabStateHandler

    var body: some View {
        TabView(selection: $tabStateHandler.tabSelected) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.Home.rawValue)
                }.tag(Tab.Home)
            MyListView()
                .tabItem {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.MyList.rawValue)
                }.tag(Tab.MyList)
            RankingView()
                .tabItem {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.Ranking.rawValue)
                }.tag(Tab.Ranking)
            MainSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.Search.rawValue)
                }.tag(Tab.Search)
            MainActivityView()
                .tabItem {
                    Image(systemName: "megaphone")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.Activity.rawValue)
                }.tag(Tab.Activity)
            MainSettingsView()
                .tabItem {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(Tab.Settings.rawValue)
                }.tag(Tab.Settings)
        }
        .onChange(of: tabStateHandler.tabSelected) { newValue in
            tabStateHandler.handleTabChange(newValue)
        }
    
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        let tabStateHandler = TabStateHandler()
        BottomTabView(tabStateHandler: tabStateHandler)
    }
}
