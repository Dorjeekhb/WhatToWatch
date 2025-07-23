//
//  FavoritesManager.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [TMDbItem] = []

    private let key = "favoriteItems"

    init() {
        load()
    }

    func isFavorite(id: Int) -> Bool {
        favorites.contains { $0.id == id }
    }

    func toggleFavorite(item: TMDbItem) {
        if isFavorite(id: item.id) {
            favorites.removeAll { $0.id == item.id }
        } else {
            favorites.append(item)
        }
        save()
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([TMDbItem].self, from: data) {
            favorites = decoded
        }
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
