//
//  NewsAPIClient.swift
//  Reader
//
//  Created by Dipesh Patel on 18/09/25.
//

import Foundation

final class NewsAPIClient {
    static let shared = NewsAPIClient()
    
    private let session = URLSession.shared
    private let baseURL = "https://newsapi.org/v2"
    
    // MARK: - API Key
    private let apiKey = "2ddfd257e0b44b1da7371d9fc132df96"
    
    private init() {}
    
    
    func fetchSources() async throws -> [Article] {
        let url = URL(string: "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)")!
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NewsAPIError.invalidResponse
        }
        
        let headlines = try JSONDecoder().decode(Headlines.self, from: data)
        return headlines.articles ?? []
    }
    
    func downloadImage(urlStr: String?) async throws -> Data? {
        guard let urlStr = urlStr,
              let url = URL(string: urlStr) else {
            return nil
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return nil
        }
        
        return data
    }
}

// MARK: - Error Handling

enum NewsAPIError: Error, LocalizedError {
    case invalidResponse
    case invalidURL
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        }
    }
}
