//
// ComicViewer.swift
// SwiftComick
//
// Created by Adri Driyo on 30/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

struct ComicViewer: View {
    let images: [ComicImage]
    
    @State private var currentIndex = 0
    @State private var isShowingImage = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<images.count,id: \.self) { index in
                            let comicImage = images[index]
                            AsyncImageView(
                                url: URL(string: comicImage.imageURL),
                                comicImage: comicImage,
                                placeholder: Image(systemName: "photo"),
                                failurePlaceholder: Image(systemName: "goforward")
                            ) { image in
                                image
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .onTapGesture {
                                currentIndex = index
                                isShowingImage.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AsyncImageView: View {
    @State private var imageURL: URL?
    let comicImage: ComicImage
    let placeholder: Image
    let failurePlaceholder: Image
    let content: (Image) -> Image
    @State private var uniqueID: Int = 0
    
    init(url: URL?,comicImage: ComicImage,  placeholder: Image, failurePlaceholder: Image, @ViewBuilder content: @escaping (Image) -> Image) {
        self._imageURL = State(initialValue: url)
        self.comicImage = comicImage
        self.placeholder = placeholder
        self.failurePlaceholder = failurePlaceholder
        self.content = content
    }
    
    var body: some View {
        if let url = imageURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                        .resizable()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    content(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Button(action: {
                        imageURL = URL(string: comicImage.imageURL)
                        uniqueID += 1
                    }) {
                        failurePlaceholder
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            placeholder
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

struct ComicViewer_Previews: PreviewProvider {
    static var previews: some View {
        ComicViewer(images: Dummy.images())
    }
}
