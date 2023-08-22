//
// _Secrets.swift
// SwiftComick
//
// Created by Adri Driyo on 17/08/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

enum Secrets {
    static let supabaseURL = URL(string: ProcessInfo.processInfo.environment["SUPABASE_URL"] ?? "")!
    static let supabaseAnonKey = ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"] ?? ""
}
