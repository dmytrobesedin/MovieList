//
//  MoviesData.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import Foundation

struct MoviesData: Codable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    // should delete
//    let adult: Bool
//    let backdropPath: String
//    let genreIDS: [Int]
//    let originalLanguage, originalTitle, overview: String
   // let popularity: Double
    let posterPath, releaseDate, title: String
    // should delete
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        // should delete
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
        case id
        // should delete
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
      //  case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        // should delete 
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}
