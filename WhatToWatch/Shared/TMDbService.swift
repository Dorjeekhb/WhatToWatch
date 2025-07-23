//
//  TMDbService.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation

struct TMDbResponse: Decodable {
    let results: [TMDbItem]
}

class TMDbService {
    static let shared = TMDbService()
    private init() {}
    
    private let apiKey = "c74a3eaa52bfaa8df9b36f9522bf9ce9"
    
    func fetchRandomItem(type: String, completion: @escaping (TMDbItem?) -> Void) {
        let discoverURL = "https://api.themoviedb.org/3/discover/\(type)?api_key=\(apiKey)&language=es-ES&sort_by=popularity.desc"
        
        guard let url = URL(string: discoverURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(TMDbResponse.self, from: data),
                  let random = decoded.results.randomElement() else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let detailURL = "https://api.themoviedb.org/3/\(type)/\(random.id)?api_key=\(self.apiKey)&language=es-ES"
            guard let detailURLObj = URL(string: detailURL) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            URLSession.shared.dataTask(with: detailURLObj) { data, _, _ in
                guard let data = data,
                      let fullItem = try? JSONDecoder().decode(TMDbItem.self, from: data) else {
                    DispatchQueue.main.async { completion(nil) }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(fullItem)
                }
            }.resume()
        }.resume()
    }
    func fetchCast(for type: String, id: Int, completion: @escaping ([CastMember]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/\(type)/\(id)/credits?api_key=\(apiKey)&language=es-ES"
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            
            struct CreditsResponse: Decodable {
                let cast: [CastMember]
            }
            
            let credits = try? JSONDecoder().decode(CreditsResponse.self, from: data)
            DispatchQueue.main.async {
                completion(credits?.cast ?? [])
            }
        }.resume()
    }
}
