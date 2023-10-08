//
// ComicImageDTO.swift
// SwiftComick
//
// Created by Adri Driyo on 08/10/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct ComicImageDTO: Identifiable, Hashable, Decodable {
    let id: String
    let chapter_id: String
    let url: String
    let created_at: Date
}
