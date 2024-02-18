//
//  CharactersListView.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct CharactersListView: View {
    let store: StoreOf<CharactersListReducer>

    var body: some View {
        switch store.dataLoadingStatus {
        case .notStarted:
            Text("Press load button to fetch characters list")
            Button("Load") {
                store.send(.fetchCharacters)
            }
            .buttonStyle(.bordered)
        case .error:
            ErrorView(
                message: "Oops, we couldn't fetch characters list",
                retryAction: { store.send(.fetchCharacters) }
            )
        default:
            NavigationView {
                List {
                    ForEach(store.characters, id: \.id) { character in

                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharacterRow(character: character, isFavorite: store.favoritesList.contains(character.id)) {
                                store.send(.toggleFavorite(character))
                            }
                        }
                    }
                    if store.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    } else if !store.isLoadedAll {
                        Color.clear
                            .onAppear {
                                store.send(.fetchCharacters)
                            }
                    }
                }
                .navigationTitle("Characters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Go Back") {
                            store.send(.resetState)
                        }
                    }
                })
            }
        }
    }
}

#Preview {
    CharactersListView(
        store: Store(initialState: CharactersListReducer.State()) {
            CharactersListReducer()
        }
    )
}
