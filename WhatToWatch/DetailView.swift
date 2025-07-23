//
//  DetailView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import SwiftUI

struct DetailView: View {
    let item: TMDbItem
    @EnvironmentObject var favorites: FavoritesManager
    @State private var trailerURL: URL? = nil
    @State private var showTrailer = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: item.imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 250)
                            .cornerRadius(12)
                    } else {
                        ProgressView()
                    }
                }

                Text(item.displayName)
                    .font(.title)

                Text("⭐ \(String(format: "%.1f", item.vote_average))")
                    .font(.subheadline)

                Text("📅 \(item.formattedDate)")
                    .font(.caption)

                Text(item.overview)
                    .font(.body)
                    .padding(.top)

                Button(favorites.isFavorite(id: item.id) ? "💛 Guardado" : "⭐ Guardar") {
                    favorites.toggleFavorite(item: item)
                }
                .buttonStyle(.borderedProminent)

                if let url = trailerURL {
                    NavigationLink("🎞️ Ver tráiler", destination: TrailerPlayerView(videoURL: url))
                }
            }
            .padding()
        }
        .onAppear {
            TMDbService.shared.fetchTrailer(for: item.first_air_date != nil ? "tv" : "movie", id: item.id) { url in
                trailerURL = url
            }
        }
    }
}
