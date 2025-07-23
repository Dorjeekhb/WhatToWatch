//
//  WhatToWatchApp.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI

@main
struct WhatToWatchApp: App {
    @StateObject private var favorites = FavoritesManager()
    @StateObject private var history = RecommendationHistoryManager()

    init() {
        _ = WatchSessionManager.shared
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if !granted {
                print("⚠️ Notificaciones no permitidas")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
                .environmentObject(history)
        }
    }
}
