//
// ComicChapter.swift
// SwiftComick
//
// Created by Adri Driyo on 24/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct ComicChapter: Identifiable, Hashable {
    let id: Int
    let number: String
    let uploadDate: Date
    let images: [ComicImage]
}
