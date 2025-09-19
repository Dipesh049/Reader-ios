//
//  NewsList+CoreDataProperties.swift
//  Reader
//
//  Created by Dipesh Patel on 18/09/25.
//
//

import Foundation
import CoreData


extension NewsArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsArticle> {
        return NSFetchRequest<NewsArticle>(entityName: "NewsArticle")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var author: String?
    @NSManaged public var id: NSUUID?
    @NSManaged public var isBookmarked: Bool

}

extension NewsArticle : Identifiable {

}
