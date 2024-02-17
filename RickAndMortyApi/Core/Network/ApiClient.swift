//
//  ApiClient.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct ApiClient {
    private static let baseUrl = "https://rickandmortyapi.com"
    var fetchCharacters: @Sendable (Int) async throws -> CharactersDTO

    struct Failure: Error, Equatable {}
}

extension DependencyValues {
  var apiClient: ApiClient {
    get { self[ApiClient.self] }
    set { self[ApiClient.self] = newValue }
  }
}

extension ApiClient: DependencyKey {
    static let liveValue = Self(
        fetchCharacters: { page in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: Self.baseUrl + "/api/character/?page=\(page)")!)
            let characters = try JSONDecoder().decode(CharactersDTO.self, from: data)
            return characters
        }
    )
}

extension ApiClient: TestDependencyKey {
    static let previewValue = Self(
        fetchCharacters: { _ in .mock() }
    )
}


