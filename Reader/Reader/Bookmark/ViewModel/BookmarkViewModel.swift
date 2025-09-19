//
//  BookmarkViewModel.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import Foundation


final class BookmarksViewModel {
    
    /// variables
    private let repository: SourcesRepositoryProtocol
    private let dataManager: NewsDBManager
    private(set) var allSources: [NewsArticle] = []
    private(set) var filtered: [NewsArticle] = []

    var onChange: (() -> Void)?

    init(repository: SourcesRepositoryProtocol = SourcesRepository(), dataManager: NewsDBManager = CoreDataManager.shared) {
        self.repository = repository
        self.dataManager = dataManager
    }
    
    func loadBookmarkArticle() {
        allSources = dataManager.fetchBookmarkedArticle()
    }

    func updateBookmark(article: NewsArticle, index: Int) {
        let article = Article(id: article.id as UUID?, source: nil, author: nil, title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        allSources.remove(at: index)
        dataManager.updateBookmark(article: article)
    }
}
