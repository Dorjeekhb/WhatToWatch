//
//  RecommendationHistoryManager.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import Foundation

class RecommendationHistoryManager: ObservableObject {
    @Published var history: [TMDbItem] = []

    private let key = "recommendationHistory"

    init() {
        load()
    }

    func add(_ item: TMDbItem) {
        guard !history.contains(where: { $0.id == item.id }) else { return }
        history.insert(item, at: 0)
        if history.count > 50 { history.removeLast() }
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([TMDbItem].self, from: data) {
            history = decoded
        }
    }
}
