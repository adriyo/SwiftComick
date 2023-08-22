//
// ComicDTO.swift
// SwiftComick
//
// Created by Adri Driyo on 17/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct ComicDTO: Identifiable, Hashable, Decodable {
    let id: UUID
    let created_at: Date
    let image_cover_url: String
    let title: String
    let description: String
}
