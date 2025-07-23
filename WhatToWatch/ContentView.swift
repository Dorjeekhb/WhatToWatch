//
//  ContentView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var favorites: FavoritesManager
    @EnvironmentObject var history: RecommendationHistoryManager
    @State private var item: TMDbItem? = nil
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("🎬 What To Watch (iOS)")
                    .font(.title)
                    .padding()

                if isLoading {
                    ProgressView("Cargando...")
                } else if let item = item {
                    NavigationLink(destination: DetailView(item: item)) {
                        VStack {
                            AsyncImage(url: item.imageURL) { phase in
                                switch phase {
                                case .empty: ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                case .failure: Image(systemName: "photo")
                                @unknown default: EmptyView()
                                }
                            }

                            Text(item.displayName)
                                .font(.headline)
                            Text("⭐ \(String(format: "%.1f", item.vote_average))")
                                .font(.caption)
                        }
                    }

                    Button("🔁 Otra recomendación") {
                        fetchItem()
                    }
                    .padding(.top)
                }

                NavigationLink("⭐ Favoritos", destination: FavoritesView())
            }
            .padding()
            .onAppear {
                if item == nil {
                    fetchItem()
                }
            }
            .alert("Error", isPresented: Binding<Bool>(
                get: { errorMessage != nil },
                set: { _ in errorMessage = nil }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }

    private func fetchItem() {
        isLoading = true
        TMDbService.shared.fetchRandomItem(type: "movie") { newItem in
            isLoading = false
            if let unwrapped = newItem {
                self.item = unwrapped
                history.add(unwrapped)
            } else {
                errorMessage = "No se pudo cargar la recomendación."
            }
        }
    }
}
