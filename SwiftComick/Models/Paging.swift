//
// Paging.swift
// SwiftComick
//
// Created by Adri Driyo on 08/10/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct Paging: Hashable {
    var totalPage: Int = 0
    var hasNextPage: Bool = false
    var hasPrevPage: Bool = false
}
