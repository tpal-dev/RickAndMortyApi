//
//  CharacterImage.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import SwiftUI

struct CharacterImage: View {
    var imageUrl: String
    var imageSize: CGFloat
    var body: some View {
        CachedAsyncImage(
            url: URL(string: imageUrl)!
        ) { phase in
            switch phase {
            case let .success(image):
                HStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize, height: imageSize)
                }
            case .failure:
                Text("❌").font(.system(size: imageSize * 0.8)).frame(width: imageSize, height: imageSize)
            case .empty:

                ProgressView()
                    .frame(width: imageSize, height: imageSize)

            @unknown default:

                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview {
    CharacterImage(imageUrl: Character.mock.image, imageSize: 50)
}
