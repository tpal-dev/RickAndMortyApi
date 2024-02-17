//
//  RickAndMortyApiApp.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct RickAndMortyApiApp: App {
    static let charactersListViewStore = Store(initialState: CharactersListReducer.State()) {
        CharactersListReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CharactersListView(store: RickAndMortyApiApp.charactersListViewStore)
        }
    }
}
