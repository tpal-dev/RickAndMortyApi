//
//  EpisodeDetailsReducer.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct EpisodeDetailsReducer: Reducer {
    @ObservableState
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var episode: EpisodeDTO?
    }

    enum Action: Equatable {
        case fetchEpisode(String)
        case fetchEpisodeResponse(TaskResult<EpisodeDTO>)
    }

    @Dependency(\.apiClient) var apiClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .fetchEpisode(url):

                if state.dataLoadingStatus == .loading { return .none }
                state.episode = nil
                state.dataLoadingStatus = .loading

                return .run { send in
                    await send(.fetchEpisodeResponse(TaskResult { try await apiClient.fetchEpisode(url) }
                    ))
                }
            case let .fetchEpisodeResponse(.failure(error)):
                state.dataLoadingStatus = .error
                print(error)
                print("Error getting Episode, try again later.")
                return .none

            case let .fetchEpisodeResponse(.success(response)):
                state.dataLoadingStatus = .success

                state.episode = response

                return .none
            }
        }
    }
}
