//
//  EpisodesDTO.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 18/02/2024.
//

struct EpisodeDto: Codable, Equatable {
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
