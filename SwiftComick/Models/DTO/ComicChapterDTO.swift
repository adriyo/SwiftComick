//
// ComicChapterDTO.swift
// SwiftComick
//
// Created by Adri Driyo on 08/10/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct ComicChapterDTO: Identifiable, Hashable, Decodable {
    let id: String
    let comic_id: String
    let label: String
    let created_at: Date
}
