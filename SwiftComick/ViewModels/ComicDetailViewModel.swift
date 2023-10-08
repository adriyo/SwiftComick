//
// ComicDetailViewModel.swift
// SwiftComick
//
// Created by Adri Driyo on 08/10/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

@MainActor
class ComicDetailViewModel: ObservableObject {
    private let repository: ListComicRepository
    @Published var comic: Comic
    @Published var chapter: ComicChapter?
    @Published var chapters: [ComicChapter]
    @Published var images: [ComicImage] = []
    @Published var errorMessage: String = ""
    
    init(comic: Comic) {
        self.comic = comic
        self.chapter = nil
        self.chapters = comic.chapters
        self.repository = ListComicRepository()
        debugPrint("comicdetailviewmodel, comicID: \(comic.id)")
    }
    
    func fetchChapters(comic: Comic) async {
        let result = await repository.fetchChapters(comic: comic)
        switch result {
        case .success(let chapters):
            self.chapters = chapters
        case .failure(let error):
            debugPrint("error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    func fetchChapter(chapter: ComicChapter?) async {
        guard var _chapter = chapter else { return }
        debugPrint("chapterID: \(_chapter.id)")
        let result = await repository.fetchChapter(chapter: &_chapter)
        switch result {
        case .success(let chapter):
            self.chapter = chapter
            self.images = chapter.images
        case .failure(let error):
            debugPrint("error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    
    }
    
}
