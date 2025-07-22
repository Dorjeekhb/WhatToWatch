//
//  ContentView.swift
//  WhatToWatch Watch App
//
//  Created by Dorjee on 23/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentRecommendation = sampleRecommendations.randomElement()!

    var body: some View {
        VStack(spacing: 10) {
            Text("🎬 What To Watch")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(currentRecommendation.title)
                .font(.title2)
                .fontWeight(.bold)

            Text("\(currentRecommendation.genre) · \(currentRecommendation.duration)")
                .font(.caption)
                .foregroundColor(.gray)

            Text(currentRecommendation.description)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.top, 4)

            Text("📺 \(currentRecommendation.platform)")
                .font(.caption2)
                .foregroundColor(.orange)

            Button("🔁 New Pick") {
                currentRecommendation = sampleRecommendations.randomElement()!
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
        }
        .padding()
    }
}
