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
    let id: String
    let label: String
    let uploadDate: Date
    var images: [ComicImage] = []
    var paging: Paging? = nil
}
