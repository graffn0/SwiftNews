//
//  News.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import Foundation

struct Root : Decodable {
    private enum CodingKeys : String, CodingKey { case articles = "articles" }
    let articles : [News]
}

struct News: Codable, Equatable {
    var title: String?
    var source: Source?
    var author: String?
    var publishedDate: String?
    var urlToImage: String?
    var description: String?
    var content: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case source
        case author
        case publishedDate
        case urlToImage
        case description
        case content
    }
    
    static func ==(lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title &&
            lhs.source?.name == rhs.source?.name &&
            lhs.author == rhs.author &&
            lhs.publishedDate == rhs.publishedDate &&
            lhs.urlToImage == rhs.urlToImage &&
            lhs.description == rhs.description &&
            lhs.content == rhs.content
    }
}

struct Source : Codable {
    private enum CodingKeys : String, CodingKey { case name = "name" }
    let name : String
}
