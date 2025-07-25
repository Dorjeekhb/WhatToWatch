//
//  DetailView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI
import WatchConnectivity

struct DetailView: View {
    let item: TMDbItem
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                AsyncImage(url: item.imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } else {
                        ProgressView()
                    }
                }

                Text(item.displayName)
                    .font(.headline)

                Text(item.overview)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)

                Button(favorites.isFavorite(id: item.id) ? "💛 Guardado" : "⭐ Guardar") {
                    favorites.toggleFavorite(item: item)
                    WKInterfaceDevice.current().play(.click)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
