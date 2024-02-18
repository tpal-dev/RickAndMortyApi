//
//  ErrorView.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text(":(")
                .font(.custom("AmericanTypewriter", size: 50))
            Text("")
            Text(message)
                .font(.custom("AmericanTypewriter", size: 25))
            Button {
                retryAction()
            } label: {
                Text("Retry")
                    .font(.custom("AmericanTypewriter", size: 25))
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 60)
            .background(.blue)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            message: "Oops, we couldn't fetch characters list",
            retryAction: {}
        )
    }
}
