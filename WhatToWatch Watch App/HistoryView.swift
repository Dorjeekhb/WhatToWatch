	//
//  HistoryView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var history: RecommendationHistoryManager

    var body: some View {
        List {
            if history.history.isEmpty {
                Text("Sin historial aún.")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                ForEach(history.history.prefix(20)) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack(spacing: 8) {
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
                                        .cornerRadius(4)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(item.displayName)
                                    .font(.system(size: 14, weight: .bold))
                                    .lineLimit(1)
                                Text(item.formattedDate)
                                    .font(.caption2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("📜 Historial")
    }
}
