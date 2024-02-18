//
//  CharacterRow.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    var isFavorite: Bool
    var onTapFavorite: () -> Void

    var body: some View {
        HStack {
            CharacterImage(imageUrl: character.image, imageSize: 50)
            Text(character.name)
            Spacer()

            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .padding(.trailing)
                .foregroundColor(.red)
                .onTapGesture {
                    onTapFavorite()
                }
        }
    }
}

#Preview {
    Group {
        CharacterRow(character: Character.mock, isFavorite: true) {}
        CharacterRow(character: Character.mock, isFavorite: false) {}
    }
}
