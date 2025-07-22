//
//  Recommendation.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation

struct Recommendation: Identifiable {
    let id = UUID()
    let title: String
    let genre: String
    let platform: String
    let duration: String
    let description: String
}

let sampleRecommendations: [Recommendation] = [
    Recommendation(title: "Inception", genre: "Sci-Fi", platform: "Netflix", duration: "2h 28m", description: "A mind-bending thriller about dreams within dreams."),
    Recommendation(title: "The Office", genre: "Comedy", platform: "Prime Video", duration: "22 min", description: "Everyday work life in a paper company."),
    Recommendation(title: "The Witcher", genre: "Fantasy", platform: "Netflix", duration: "1h", description: "A monster hunter with a dark past."),
    Recommendation(title: "Breaking Bad", genre: "Drama", platform: "Netflix", duration: "45 min", description: "A chemistry teacher turns drug kingpin.")
]
