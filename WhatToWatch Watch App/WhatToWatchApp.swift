//
//  WhatToWatchApp.swift
//  WhatToWatch Watch App
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI

@main
struct WhatToWatchApp: App {
    @StateObject private var favorites = FavoritesManager()
    @StateObject private var history = RecommendationHistoryManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
                .environmentObject(history)
        }
    }
}
