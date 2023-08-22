//
// ListComicRepository.swift
// SwiftComick
//
// Created by Adri Driyo on 17/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation
import Supabase

struct ListComicRepository {
    
    func fetchComics() async -> (Result<[Comic], Error>) {
        print("url: \(Secrets.supabaseURL)")
        print("key: \(Secrets.supabaseAnonKey)")
        do {
            let comicsResult: [ComicDTO] = try await supabase.database
                .from("comics")
                .execute()
                .value

            let comics = comicsResult.map { dto in
                Comic(imageUrl: dto.image_cover_url, title: dto.title, description: dto.description)
            }
            return .success(comics)
        } catch {
            return .failure(error)
        }
    }
    
}
