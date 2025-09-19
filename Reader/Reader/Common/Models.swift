//
//  Models.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import Foundation


// MARK: - Headlines
struct Headlines: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
class Article: Codable {
    var id: UUID?
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isBookmarked: Bool? = false
    
    init(id: UUID?, source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?, isBookmarked: Bool? = nil) {
        self.id = id
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.isBookmarked = isBookmarked
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    let name: String?
}




