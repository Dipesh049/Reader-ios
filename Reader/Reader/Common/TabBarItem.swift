//
//  TabBarItem.swift
//  Reader
//
//  Created by Dipesh Patel on 19/09/25.
//


import UIKit

enum TabBarItem: String, CaseIterable {
    case home
    case bookmarks
}
 
extension TabBarItem {
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeVC()
        case .bookmarks:
            return BookMarkVC()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .bookmarks:
            return UIImage(systemName: "bookmark")
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")
        case .bookmarks:
            return UIImage(systemName: "bookmark.fill")
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}
