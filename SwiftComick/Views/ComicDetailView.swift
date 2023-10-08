//
// ComicDetailView.swift
// SwiftComick
//
// Created by Adri Driyo on 24/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

struct ComicDetailView: View {
    
    let comic: Comic
    @StateObject private var viewModel: ComicDetailViewModel

    init(_ comic: Comic) {
        _viewModel = StateObject(wrappedValue: ComicDetailViewModel(comic: comic))
        self.comic = comic
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    RectangleImageView(comic: comic, showTitle: false)
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Read Ch. 1")
                    }
                    .frame(width: 150)
                    .buttonStyle(.bordered)
                    .padding(.vertical, 10)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "bookmark.fill")
                        Text("Follow")
                    }
                    .frame(width: 150)
                    .buttonStyle(.bordered)
                    .padding(.vertical, 10)
                    
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Spacer()
                
                Group {
                    VStack {
                        Text("Description")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(comic.description.escapedHTML())
                            .font(.callout)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, 20)
                
                ComicDetailChaptersView(chapters: viewModel.chapters, viewModel: viewModel)
            }
            .padding()
        }
        .navigationTitle(comic.title)
        .refreshable {
            await viewModel.fetchChapters(comic: comic)
        }
        .task {
            await viewModel.fetchChapters(comic: comic)
        }
    }
}

private struct ComicDetailChaptersView: View {
    
    let chapters: [ComicChapter]
    let viewModel: ComicDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Chapters")
                .font(.title2)
            
            ForEach(chapters, id: \.self) { chapter in
                NavigationLink(destination: ComicViewer(chapter: chapter, viewModel: viewModel)) {
                    RowChapterView(chapter: chapter)
                }
            }
        }
    }
}

private struct RowChapterView: View {
    
    let chapter: ComicChapter
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                HStack {
                    Text("Ch. \(chapter.label)")
                        .frame(width: geometry.size.width * 0.5, alignment: .leading)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(chapter.uploadDate.getUploadedDate())")
                        .font(.callout)
                        .frame(width: geometry.size.width * 0.5)
                }
            }
            .padding(.vertical)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
        }
        .background(.mint)
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(Dummy.getComics()[0])
    }
}
