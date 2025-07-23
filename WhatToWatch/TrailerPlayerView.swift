//
//  TrailerPlayerView.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import SwiftUI

struct TrailerPlayerView: View {
    let videoURL: URL

    var body: some View {
        VStack(spacing: 20) {
            Text("🎞️ Abrir tráiler en YouTube")
                .font(.title2)
                .multilineTextAlignment(.center)

            Button {
                UIApplication.shared.open(videoURL)
            } label: {
                Label("Ver en YouTube", systemImage: "play.rectangle.fill")
                    .font(.title2)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
