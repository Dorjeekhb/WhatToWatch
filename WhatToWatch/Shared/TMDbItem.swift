//
//  TMDbItem.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct TMDbItem: Identifiable, Codable {
    let id: Int
    let name: String?
    let title: String?
    let overview: String
    let poster_path: String?
    let vote_average: Double
    let first_air_date: String?
    let release_date: String?
    let number_of_seasons: Int?
    let number_of_episodes: Int?
    let genres: [Genre]?

    var displayName: String {
        name ?? title ?? "Sin título"
    }

    var imageURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var formattedDate: String {
        let raw = first_air_date ?? release_date
        guard let raw = raw else { return "?" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: raw) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return raw
    }
}
struct CastMember: Identifiable, Codable {
    let id: Int
    let name: String
    let profile_path: String?

    var imageURL: URL? {
        guard let path = profile_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
}
