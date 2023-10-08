//
// HomeViewModel.swift
// SwiftComick
//
// Created by Adri Driyo on 17/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

@MainActor
class ListComicsViewModel: ObservableObject {
    
    private let repository: ListComicRepository
    
    @Published var mostViewedComics: [Comic] = []
    @Published var recentlyAddedComics: [Comic] = []
    @Published var popularComics: [Comic] = []
    @Published var completedComics: [Comic] = []
    @Published var updatesComics: [Comic] = []
    @Published var errorMessage: String = ""
    
    init() {
        self.repository = ListComicRepository()
    }
    
    func fetchComics() async {
        
        let result = await repository.fetchComics()
        switch result {
        case .success(let comics):
            self.mostViewedComics = comics
            self.recentlyAddedComics = comics
            self.popularComics = comics
            self.completedComics = comics
            self.updatesComics = comics
        case .failure(let error):
            debugPrint("error: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
        
    }
    
}
