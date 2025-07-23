//
//  FavoritesView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        List {
            if favorites.favorites.isEmpty {
                Text("No hay favoritos todavía.")
            } else {
                ForEach(favorites.favorites) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            AsyncImage(url: item.imageURL) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(4)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 60)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(item.displayName)
                                Text(item.formattedDate)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("⭐ Favoritos")
    }
}
