//
//  MovieResponse.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let posterPath, releaseDate, title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
