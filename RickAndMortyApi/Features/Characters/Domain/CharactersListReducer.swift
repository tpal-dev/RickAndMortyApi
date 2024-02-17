//
//  CharactersListReducer.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

//
//  CounterFeature.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 16/02/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CharactersListReducer: Reducer {
    @ObservableState
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var characters: [Character] = []
        var pageCount = 0

        var isLoadedAll: Bool {
            dataLoadingStatus == .paginationLimitReached
        }

        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
    }

    enum Action: Equatable {
        case fetchCharacters
        case fetchCharactersResponse(TaskResult<CharactersDTO>)
        case resetState
    }

    @Dependency(\.apiClient) var apiClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCharacters:
                if state.dataLoadingStatus == .loading || state.dataLoadingStatus == .paginationLimitReached { return .none }

                state.dataLoadingStatus = .loading
                state.pageCount += 1
                let pagination = state.pageCount

                return .run { send in
                    await send(.fetchCharactersResponse(TaskResult { try await apiClient.fetchCharacters(pagination) }
                    ))
                }
            case let .fetchCharactersResponse(.failure(error)):
                state.dataLoadingStatus = .error
                print(error)
                print("Error getting Characters, try again later.")
                return .none

            case let .fetchCharactersResponse(.success(response)):
                state.dataLoadingStatus = state.pageCount < response.info.count ? .success : .paginationLimitReached

                for character in response.results {
                    state.characters.append(character)
                }
                return .none
            case .resetState:
                state.characters = []
                state.pageCount = 0
                state.dataLoadingStatus = .notStarted
                return .none
            }
        }
    }
}
