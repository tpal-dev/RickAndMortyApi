//
//  CharacterRow.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    let imageSize: CGFloat  = 50
    var body: some View {
        HStack {
            CachedAsyncImage(
                url: URL(string: character.image)!
            ) { phase in
                switch phase {
                case .success(let image):
                    HStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageSize, height: imageSize)
                    }
                case .failure:
                    Text("❌").font(.system(size: 40)).frame(width: imageSize, height: imageSize)
                case .empty:
                    HStack {
                        ProgressView()
                            .frame(height: imageSize)
                       
                    }
                @unknown default:
                    // AsyncImagePhase is not marked as @frozen.
                    // We need to support new cases in the future.
                    Image(systemName: "questionmark")
                }}
            Text(character.name)

            Spacer()
        }
    }
}

#Preview {
    Group {
        CharacterRow(character: Character.mock)
        CharacterRow(character: Character.mock)
    }
}
