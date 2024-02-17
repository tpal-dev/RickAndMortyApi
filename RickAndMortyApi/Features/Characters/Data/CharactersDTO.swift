//
//  CharactersDTO.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import Foundation

struct CharactersDTO: Codable, Equatable {
    let info: Info
    let results: [Character]

    struct Info: Codable, Equatable {
        let count, pages: Int
        let next, prev: String?
    }
}

struct Character: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String

    struct Origin: Codable, Equatable {
        let name: String
        let url: String
    }

    struct Location: Codable, Equatable {
        let name: String
        let url: String
    }
}

extension Character {
    static let mock = Self(id: 21, name: "Aqua Morty", status: "unknown", species: "Humanoid", type: "Fish-Person", gender: "Male", origin: Origin(name: "unknown", url: ""), location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/21.jpeg", episode: ["https://rickandmortyapi.com/api/episode/10", "https://rickandmortyapi.com/api/episode/22"], url: "https://rickandmortyapi.com/api/character/21", created: "2017-11-04T22:39:48.055Z")
}

extension CharactersDTO {
    static let mock = {
        let json = """
        {
        "info": {
        "count": 826,
        "pages": 42,
        "next": "https://rickandmortyapi.com/api/character/?page=3",
        "prev": "https://rickandmortyapi.com/api/character/?page=1"
        },
        "results": [
        {
        "id": 21,
        "name": "Aqua Morty",
        "status": "unknown",
        "species": "Humanoid",
        "type": "Fish-Person",
        "gender": "Male",
        "origin": {
        "name": "unknown",
        "url": ""
        },
        "location": {
        "name": "Citadel of Ricks",
        "url": "https://rickandmortyapi.com/api/location/3"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/21.jpeg",
        "episode": [
        "https://rickandmortyapi.com/api/episode/10",
        "https://rickandmortyapi.com/api/episode/22"
        ],
        "url": "https://rickandmortyapi.com/api/character/21",
        "created": "2017-11-04T22:39:48.055Z"
        },
        {
        "id": 22,
        "name": "Aqua Rick",
        "status": "unknown",
        "species": "Humanoid",
        "type": "Fish-Person",
        "gender": "Male",
        "origin": {
        "name": "unknown",
        "url": ""
        },
        "location": {
        "name": "Citadel of Ricks",
        "url": "https://rickandmortyapi.com/api/location/3"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/22.jpeg",
        "episode": [
        "https://rickandmortyapi.com/api/episode/10",
        "https://rickandmortyapi.com/api/episode/22",
        "https://rickandmortyapi.com/api/episode/28"
        ],
        "url": "https://rickandmortyapi.com/api/character/22",
        "created": "2017-11-04T22:41:07.171Z"
        },
        {
        "id": 23,
        "name": "Arcade Alien",
        "status": "unknown",
        "species": "Alien",
        "type": "",
        "gender": "Male",
        "origin": {
        "name": "unknown",
        "url": ""
        },
        "location": {
        "name": "Immortality Field Resort",
        "url": "https://rickandmortyapi.com/api/location/7"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/23.jpeg",
        "episode": [
        "https://rickandmortyapi.com/api/episode/13",
        "https://rickandmortyapi.com/api/episode/19",
        "https://rickandmortyapi.com/api/episode/21",
        "https://rickandmortyapi.com/api/episode/25",
        "https://rickandmortyapi.com/api/episode/26"
        ],
        "url": "https://rickandmortyapi.com/api/character/23",
        "created": "2017-11-05T08:43:05.095Z"
        },
        {
        "id": 24,
        "name": "Beth's Mytholog",
        "status": "Dead",
        "species": "Mythological Creature",
        "type": "Mytholog",
        "gender": "Female",
        "origin": {
        "name": "Nuptia 4",
        "url": "https://rickandmortyapi.com/api/location/13"
        },
        "location": {
        "name": "Nuptia 4",
        "url": "https://rickandmortyapi.com/api/location/13"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/40.jpeg",
        "episode": [
        "https://rickandmortyapi.com/api/episode/18"
        ],
        "url": "https://rickandmortyapi.com/api/character/40",
        "created": "2017-11-05T10:02:26.701Z"
        }
        ]
        }
        """.data(using: .utf8)!
        return try! JSONDecoder().decode(CharactersDTO.self, from: json)
    }
}
