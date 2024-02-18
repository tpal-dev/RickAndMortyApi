//
//  CharacterDetailView.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct CharacterDetailView: View {
    var character: Character

    var body: some View {
        VStack {
            Color.cyan
                .frame(width: .infinity, height: 150)

            CharacterImage(imageUrl: character.image, imageSize: 200)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                    .padding(.horizontal)

                VStack(alignment: .leading) {
                    Text("Status: " + character.status)
                    Text("Gender: " + character.gender)
                    Text("Origin: " + character.origin.name)
                    Text("Location: " + character.location.name)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                Divider()
            }

            Text("List of episodes in which this character appeared")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Divider()
            List {
                ForEach(character.episodes, id: \.self) { episode in

                    NavigationLink {
                        EpisodeDetailView(store: Store(initialState: EpisodeDetailsReducer.State()) {
                            EpisodeDetailsReducer()
                                ._printChanges()
                        }, episodeUrl: episode.url)
                    } label: {
                        Text(episode.name)
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterDetailView(character: Character.mock)
}
