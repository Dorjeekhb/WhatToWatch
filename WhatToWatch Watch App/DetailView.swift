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
    @State private var cast: [CastMember] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                AsyncImage(url: item.imageURL) { phase in
                    switch phase {
                    case .empty: ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    case .failure: Image(systemName: "photo")
                    @unknown default: EmptyView()
                    }
                }
                .frame(height: 140)

                Text(item.displayName)
                    .font(.headline)

                Text("⭐ \(String(format: "%.1f", item.vote_average))")
                    .font(.caption)

                Text("📅 \(item.formattedDate)")
                    .font(.caption2)

                Text(item.overview)
                    .font(.body)
                    .padding(.top, 6)

                Button {
                    favorites.toggleFavorite(item: item)
                } label: {
                    Label(
                        favorites.isFavorite(id: item.id) ? "Guardado ⭐" : "Guardar favorito",
                        systemImage: favorites.isFavorite(id: item.id) ? "star.fill" : "star"
                    )
                }
                .buttonStyle(.borderedProminent)

                if !cast.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("🎭 Reparto")
                            .font(.headline)

                        ForEach(cast.prefix(5)) { actor in
                            HStack {
                                AsyncImage(url: actor.imageURL) { phase in
                                    switch phase {
                                    case .empty: ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }

                                Text(actor.name)
                                    .font(.caption)
                                    .padding(.leading, 6)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            TMDbService.shared.fetchCast(for: favoritesType(), id: item.id) { fetched in
                cast = fetched
            }
        }
    }

    private func favoritesType() -> String {
        return item.first_air_date != nil ? "tv" : "movie"
    }
}

