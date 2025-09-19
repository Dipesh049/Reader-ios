//
//  HomeViewModel.swift
//  Reader
//
//  Created by Dipesh Patel on 16/09/25.
//

import Foundation


final class HomeViewModel {
    private let repository: SourcesRepositoryProtocol
    private let dataManager: NewsDBManager
    private(set) var allSources: [Article] = []
    private(set) var filtered: [Article] = []

    var onChange: (() -> Void)?

    init(repository: SourcesRepositoryProtocol = SourcesRepository(), dataManager: NewsDBManager = CoreDataManager.shared) {
        self.repository = repository
        self.dataManager = dataManager
    }

    func loadFromApi(force: Bool = false) async {
        loadFromDB()
        do {
            let sources = try await repository.getSources(forceRefresh: force)
            self.dataManager.saveArticles(articles: sources)
            allSources = sources
            syncSourceToDB()
            filteredData(str: "")
            onChange?()
        } catch {
            // Keep current and notify
        }
    }
    
    func loadFromDB() {
        let articles = dataManager.fetchArticles()
        for article in articles {
            self.allSources.append(Article(id: article.id as UUID?, source: nil, author: article.author, title: article.title, description: article.description, url: nil, urlToImage: article.imgUrl, publishedAt: nil, content: article.content))
        }
        onChange?()
    }
    
    func syncSourceToDB() {
        // Fetch articles from the data manager
        let articles = dataManager.fetchArticles()

            // Loop through each article
        for source in allSources {
            if let arti = articles.first(where: {$0.title == source.title}) {
                source.isBookmarked = arti.isBookmarked
                source.id = arti.id as? UUID
            }
        }
    }
    
    func filteredData(str: String) {
        if str.isEmpty {
            filtered = allSources
        } else {
            filtered = allSources.filter({$0.title?.contains(str) ?? false})
        }
        onChange?()
    }
    
    func isBookmarked(article: Article) -> Bool {
        debugPrint("uuid\(article.id)- isBookmarked \(dataManager.isBookmarked(articleID: article.id))")
        return dataManager.isBookmarked(articleID: article.id)
    }

    func bookmarkArticle(article: Article) {
        article.isBookmarked?.toggle()
        dataManager.updateBookmark(article: article)
    }
    
}
