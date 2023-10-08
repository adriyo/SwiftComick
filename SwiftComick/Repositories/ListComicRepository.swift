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
        do {
            let comicsResult: [ComicDTO] = try await supabase.database
                .from("comics")
                .select(columns:"*")
                .order(column: "id", ascending: true)
                .execute()
                .value

            let comics = comicsResult.map { dto in
                Comic(id: dto.id, imageUrl: dto.image_cover_url, title: dto.title, description: dto.description)
            }
            
            return .success(comics)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchChapters(comic: Comic) async -> (Result<[ComicChapter], Error>) {
        do {
            
            let chaptersResult: [ComicChapterDTO] = try await supabase.database
                .from("comic_chapters")
                .select()
                .eq(column: "comic_id", value: comic.id)
                .execute()
                .value
            let chapters = chaptersResult.map { dto in
                ComicChapter(id: dto.id, label: dto.label, uploadDate: dto.created_at, images: Dummy.images())
            }
            return .success(chapters)
        } catch {
            debugPrint(error)
            return .failure(error)
        }
    }
    
    func fetchChapter(chapter: inout ComicChapter) async -> (Result<ComicChapter, Error>) {
        do {
            let chapterImagesResult: [ComicImageDTO] = try await supabase.database
                .from("chapter_images")
                .select()
                .eq(column: "chapter_id", value: chapter.id)
                .execute()
                .value
            
            let paging = Paging(totalPage: 10, hasNextPage: true, hasPrevPage: true)
            let images = chapterImagesResult.map { dto in
                ComicImage(id: dto.id, imageURL: dto.url)
            }
            chapter.images = images
            chapter.paging = paging
            debugPrint("images: \(images.count)")
            return .success(chapter)
        } catch {
            debugPrint(error)
            return .failure(error)
        }
    }
    
}
