//
//  MovieDatabaseURL.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import Foundation

enum MovieDatabaseURL {
    static let apiKey = "a44140e86c7e80f678a6a3a2549edae4"

    case nowPlaying
    case popular
    case posterStorageURL(imagePath: String)

    var urlString: String {
        switch self {
        case .nowPlaying:
            return "https://api.themoviedb.org/3/movie/now_playing"
        case .popular:
            return "https://api.themoviedb.org/3/movie/popular"
        case .posterStorageURL(let imagePath):
            return "https://image.tmdb.org/t/p/w300" + imagePath
        }
    }
}

