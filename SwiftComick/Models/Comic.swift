//
// Comic.swift
// SwiftComick
//
// Created by Adri Driyo on 22/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct Comic: Identifiable, Hashable {
    let id = UUID()
    let imageUrl: String
    let title: String
}
