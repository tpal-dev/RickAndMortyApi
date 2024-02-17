//
//  CharactersListView.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//


import SwiftUI
import ComposableArchitecture

struct CharactersListView: View {
    let store: StoreOf<CharactersListReducer>

    var body: some View {
        NavigationView {
            List {
                if let characters = store.characters {
                    ForEach(characters, id: \.id) { character in
                        Text(character.name)
                    }
                    if (store.isLoading) {
                        ProgressView()
                                               .progressViewStyle(.circular)
                                               .frame(maxWidth: .infinity)
                    } else {
                        Color.clear
                                               .onAppear {
                                                   store.send(.fetchCharacters)
                                               }
                    }
                } else {
                    Text("Sorry...")
                }
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Load ") {
                        store.send(.fetchCharacters)
                    }
                }
            })
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

