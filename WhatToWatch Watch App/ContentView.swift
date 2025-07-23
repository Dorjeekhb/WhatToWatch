//
//  ContentView.swift
//  WhatToWatch Watch App
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI

enum ContentType: String {
    case tv = "tv"
    case movie = "movie"
}

struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}

struct ContentView: View {
    @EnvironmentObject var favorites: FavoritesManager
    @EnvironmentObject var history: RecommendationHistoryManager
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedType: ContentType? = nil
    @State private var item: TMDbItem? = nil
    @State private var isLoading = false
    @State private var showDetail = false
    @State private var errorMessage: ErrorMessage? = nil
    @State private var scrollAnchor = UUID()
    @Namespace private var animation

    var body: some View {
        NavigationStack {
            Group {
                if selectedType == nil {
                    VStack(spacing: 16) {
                        Text("¿Qué quieres ver?")
                            .font(.headline)
                        Button("📺 Series") {
                            withAnimation {
                                selectedType = .tv
                                fetchItem()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        Button("🎬 Películas") {
                            withAnimation {
                                selectedType = .movie
                                fetchItem()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    recommendationView
                        .transition(.opacity)
                        .animation(.easeInOut, value: item?.id)
                }
            }
            .navigationDestination(isPresented: $showDetail) {
                if let item = item {
                    DetailView(item: item)
                        .environmentObject(favorites)
                }
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .alert(item: $errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("OK")))
        }
    }

    @ViewBuilder
    var recommendationView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 12) {
                    Color.clear
                        .frame(height: 0)
                        .id(scrollAnchor)

                    Text("🎬 What To Watch")
                        .font(.headline)

                    if isLoading {
                        ProgressView("Cargando...")
                    } else if let show = item {
                        VStack(spacing: 8) {
                            AsyncImage(url: show.imageURL) { phase in
                                switch phase {
                                case .empty: ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(6)
                                        .matchedGeometryEffect(id: "poster\(show.id)", in: animation)
                                case .failure: Image(systemName: "photo")
                                @unknown default: EmptyView()
                                }
                            }
                            .frame(height: 120)

                            Text(show.displayName)
                                .font(.title3)
                                .bold()
                                .multilineTextAlignment(.center)

                            Text("⭐ \(String(format: "%.1f", show.vote_average))")
                                .font(.caption)

                            Text("📅 Estreno: \(show.formattedDate)")
                                .font(.caption2)

                            if let genres = show.genres, !genres.isEmpty {
                                Text("🎭 Género: \(genres.prefix(2).map(\.name).joined(separator: ", "))")
                                    .font(.caption2)
                            }

                            if let seasons = show.number_of_seasons,
                               let episodes = show.number_of_episodes,
                               seasons > 0 {
                                Text("📺 \(seasons) temporada(s), \(episodes) episodio(s)")
                                    .font(.caption2)
                            }

                            HStack(spacing: 8) {
                                Button {
                                    withAnimation {
                                        showDetail = true
                                    }
                                } label: {
                                    VStack {
                                        Image(systemName: "text.book.closed.fill")
                                            .font(.title2)
                                        Text("Sinopsis")
                                            .font(.caption2)
                                    }
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(8)
                                }

                                Button {
                                    withAnimation {
                                        fetchItem()
                                    }
                                } label: {
                                    VStack {
                                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                            .font(.title2)
                                        Text("Otra")
                                            .font(.caption2)
                                    }
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(8)
                                }
                            }

                            NavigationLink(destination: FavoritesView()
                                           .environmentObject(favorites)) {
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("Ver favoritos")
                                        .font(.caption)
                                }
                                .padding(6)
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow.opacity(0.2))
                                .cornerRadius(8)
                            }

                            NavigationLink(destination: HistoryView()
                                           .environmentObject(history)) {
                                HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                    Text("Ver historial reciente")
                                        .font(.caption)
                                }
                                .padding(6)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                    } else {
                        Text("Error al cargar")
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
            .onChange(of: item?.id) { _ in
                withAnimation {
                    proxy.scrollTo(scrollAnchor, anchor: .top)
                }
            }
            .onAppear {
                if item == nil {
                    fetchItem()
                }
            }
        }
    }

    private func fetchItem() {
        guard let type = selectedType else { return }
        isLoading = true
        TMDbService.shared.fetchRandomItem(type: type.rawValue) { newItem in
            withAnimation {
                self.isLoading = false
                if let unwrapped = newItem {
                    self.scrollAnchor = UUID()
                    self.item = unwrapped
                    history.add(unwrapped)
                } else {
                    self.errorMessage = ErrorMessage(message: "No se pudo cargar la recomendación. Verifica tu conexión.")
                }
            }
        }
    }
}
