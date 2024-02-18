//
//  EpisodeDetailView.swift
//  RickAndMortyApi

//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct EpisodeDetailView: View {
    let store: StoreOf<EpisodeDetailsReducer>
    let episodeUrl: String

    var body: some View {
        switch store.dataLoadingStatus {
        case .success:

            VStack(alignment: .leading) {
                Color.cyan
                    .frame(width: .infinity, height: 150)

                if let episodeModel = store.episode {
                    VStack(alignment: .leading) {
                        Text("Episode " + episodeModel.episode)
                            .font(.title)
                            .padding(.horizontal)

                        VStack(alignment: .leading) {
                            Text("Air Date: " + episodeModel.airDate)
                            Text("Number of characters appearing in the episode: " + String(episodeModel.characters.count))
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    }
                } else {
                    ErrorView(
                        message: "Oops, we couldn't fetch episode details",
                        retryAction: { store.send(.fetchEpisode(episodeUrl)) }
                    )
                }
                Spacer()
            }
        case .error:
            ErrorView(
                message: "Oops, we couldn't fetch characters list",
                retryAction: { store.send(.fetchEpisode(episodeUrl)) }
            )
        default:
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity)
                .onAppear {
                    store.send(.fetchEpisode(episodeUrl))
                }
        }
    }
}

// #Preview {
////    EpisodeDetailView()
// }
