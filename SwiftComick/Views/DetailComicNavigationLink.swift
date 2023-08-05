//
// DetailComicNavigationLink.swift
// SwiftComick
//
// Created by Adri Driyo on 25/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

struct DetailComicNavigationLink<Content: View>: View {
    let comic: Comic
    let content: Content
    @State private var isActive = false

    var body: some View {
        NavigationLink(destination: ComicDetailView(comic), isActive: $isActive) {
            content
        }
        .frame(width: 0, height: 0)
        .opacity(0)
    }

    func activate() {
        isActive = true
    }
}
