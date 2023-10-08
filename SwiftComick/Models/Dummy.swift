//
// Dummy.swift
// SwiftComick
//
// Created by Adri Driyo on 25/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import Foundation

struct Dummy {
    
    static let dummyURL = "https://cdn-manga.com/files/thumbnail/The%20First%20Sword%20Of%20Earth.jpg"
    static let dummyDescription = "<p>Yet his loyalty was rewarded by the blade of a guillotine dirtied by slander.</p><p>I will never live the life of a hound slaughtered after the rabbit is caught.</p>    <p>In place of death, an unexpected opportunity awaits him.</p>    <p>Vicir’s eyes glowed red as he sharpened his canines in the dark.</p>     <p>Just you wait, Hugo. I will rip out your throat this time.</p><p>It’s time for the hound to exact bloody revenge on his owner.</p>"
    static let imageURL = "https://meo3.comick.pictures/0-nfOF5BqsiQA01-m.jpg"
    
    static func getComics() -> [Comic] {
        var comics = [Comic]()
        for i in 1...10 {
            comics.append(
                Comic(id: UUID(), imageUrl: dummyURL, title: "Comic Title Number \(i)", description: dummyDescription, chapters: chapters())
            )
        }
        return comics
    }
    
    static func chapters() -> [ComicChapter] {
        var chapters = [ComicChapter]()
        for i in 1...10 {
            chapters.append(
                ComicChapter(id: "\(i)", label: "Chapter \(i+1)", uploadDate: Date(), images: images())
            )
        }
        return chapters
    }
    
    static func images() -> [ComicImage] {
        var images = [ComicImage]()
        for i in 1...10 {
            images.append(ComicImage(id: "\(i)", imageURL: imageURL))
        }
        return images
    }
}
