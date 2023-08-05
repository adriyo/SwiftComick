//
// HomeView.swift
// SwiftComick
//
// Created by Adri Driyo on 22/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

struct HomeView: View {
    
    @State var comics: [Comic] = []
    
    func initList() {
        comics = Dummy.getComics()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HorizontalImageList(comics: comics, title: "Most Viewed")
                HorizontalImageList(comics: comics, title: "Popular New Comic")
                HorizontalImageList(comics: comics, title: "Recently Added")
                HorizontalImageList(comics: comics, title: "Completed Comic")
                VerticalImageList(comics: comics, title: "Updates")
            }
            .padding()
        }
        .navigationTitle("Menu 1")
        .onAppear {
            initList()
        }
    }
}

struct HorizontalImageList: View {
    let comics: [Comic]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title)")
                .font(.title3)
                .fontWeight(.regular)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(comics) { comic in
                        NavigationLink(destination: ComicDetailView(comic)) {
                            SquareImageView(comic: comic)
                        }
                    }
                }
            }
        }
    }
}

struct VerticalImageList: View {
    let comics: [Comic]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title)")
                .font(.title3)
                .fontWeight(.regular)
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: 200)),
                                GridItem(.flexible(minimum: 150, maximum: 200))]) {
                ForEach(comics, id: \.self) { comic in
                    VStack {
                        NavigationLink(destination: ComicDetailView(comic)) {
                            RectangleImageView(comic: comic)
                        }
                    }
                }
            }
        }
    }
}

struct SquareImageView: View {
    let comic: Comic
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: comic.imageUrl)) { image in
                image
                    .resizable()
                    .cornerRadius(8)
            } placeholder: {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }
            
            Text(comic.title)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .lineLimit(2)
                .padding(.all, 8)
                .background(.black)
                .foregroundColor(.white)
            
        }
        .frame(width: 120, height: 120)
    }
}

struct RectangleImageView: View {
    let comic: Comic
    let showTitle: Bool
    
    init(comic: Comic, showTitle: Bool = true) {
        self.comic = comic
        self.showTitle = showTitle
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: comic.imageUrl)) { image in
                image
                    .resizable()
                    .cornerRadius(8)
            } placeholder: {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            }
            
            if showTitle {
                Text(comic.title)
                    .font(.caption)
            }
        }
        .frame(height: 200)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().preferredColorScheme(.dark)
    }
}
