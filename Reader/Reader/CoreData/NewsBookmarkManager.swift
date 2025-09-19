//
//  NewsBookmarkManager.swift
//  Reader
//
//  Created by Dipesh Patel on 18/09/25.
//

import CoreData


protocol NewsDBManager {
    func saveArticles(articles: [Article])
    func updateBookmark(article: Article)
    func isBookmarked(articleID: UUID?) -> Bool
    func fetchBookmarkedArticle() -> [NewsArticle]
    func fetchArticles() -> [NewsArticle]
}

extension CoreDataManager: NewsDBManager {
    func saveArticles(articles: [Article]) {
        
        // fetch existing articles
        let fetchArticles: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        var existingArticles: [NewsArticle] = []
        if let existing = try? context.fetch(fetchArticles) {
            existingArticles = existing
        }
        // uniquely identify based on title because api doesn't provide any unique id
        let existingTitle = existingArticles.map{ $0.title }
        
        var articlesToInsert: [[String: Any]] = []
        for article in articles {
            if existingTitle.contains(article.title) { continue }
            let newArticle: [String: Any] = [
                "id" : UUID(),
                "title" : article.title ?? "",
                "content" : article.content ?? "",
                "author" : article.author ?? "",
                "isBookmarked" : article.isBookmarked ?? false,
                "imgUrl" : article.urlToImage ?? "",
            ]
            articlesToInsert.append(newArticle)
        }
        
        if articlesToInsert.isEmpty {
            return
        }
        
        let insertRequest = NSBatchInsertRequest(entity: NewsArticle.entity(), objects: articlesToInsert)
        do {
            try context.execute(insertRequest)
            print("Batch insert completed.")
        } catch {
            print("Failed to batch insert articles: \(error)")
        }
    }
    
    func fetchArticles() -> [NewsArticle] {
        let fetchArticles: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        if let articles = try? context.fetch(fetchArticles) {
            return articles
        }
        
        return []
    }
    
    func updateBookmark(article: Article) {
        let fetchArticle: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        
        if let id = article.id {
            fetchArticle.predicate = NSPredicate(format: "id == %@",id as CVarArg)
            if let existing = try? context.fetch(fetchArticle).first {
                existing.isBookmarked = article.isBookmarked ?? false
            }
        } else {
            let bookMarkArticle = NewsArticle(context: context)
            bookMarkArticle.id = NSUUID()
            bookMarkArticle.title = article.title
            bookMarkArticle.content = article.content
            bookMarkArticle.author = article.author
            bookMarkArticle.isBookmarked = true
            bookMarkArticle.imgUrl = article.urlToImage
        }
        saveContext()
    }
    
    func isBookmarked(articleID: UUID?) -> Bool {
        guard let articleID else {return false}
        let fetchArticle: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        fetchArticle.predicate = NSPredicate(format: "id == %@ AND isBookmarked == YES", articleID as CVarArg)
        if let _ = try? context.fetch(fetchArticle).first {
            return true
        }
        return false
    }
    
    func fetchBookmarkedArticle() -> [NewsArticle] {
        let fetchArticles: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        
        fetchArticles.predicate = NSPredicate(format: "isBookmarked == YES")
        
        if let articles = try? context.fetch(fetchArticles) {
            return articles
        }
        return []
    }
    
}
