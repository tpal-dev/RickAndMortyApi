//
//  EpisodeDTO.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import Foundation

struct EpisodeDTO: Codable, Equatable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

extension EpisodeDTO {
    static let mock = {
        let json = """
        {
          "id": 28,
          "name": "The Ricklantis Mixup",
          "air_date": "September 10, 2017",
          "episode": "S03E07",
          "characters": [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            // ...
          ],
          "url": "https://rickandmortyapi.com/api/episode/28",
          "created": "2017-11-10T12:56:36.618Z"
        }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(EpisodeDTO.self, from: json)
    }
}
