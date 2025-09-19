//
//  Repository.swift
//  Reader
//
//  Created by Dipesh Patel on 18/09/25.
//


import Foundation

protocol SourcesRepositoryProtocol {
    func getSources(forceRefresh: Bool) async throws -> [Article]
}

final class SourcesRepository: SourcesRepositoryProtocol {
    private let api: NewsAPIClient

    init(api: NewsAPIClient = .shared) {
        self.api = api
    }

    func getSources(forceRefresh: Bool) async throws -> [Article] {
        do {
            let sources = try await api.fetchSources()
            return sources
        } catch {
            debugPrint(error)
        }
        return []
    }
}



