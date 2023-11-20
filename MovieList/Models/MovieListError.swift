//
//  MovieListError.swift
//  MovieList
//
//  Created by Dmytro Besedin on 14.11.2023.
//

import Foundation

enum MovieListError: Error {
    case failedToDecode(description: String = "Failed to decode.")
    case invalidStatusCode(description: String = "Invalid status code.")
    case failedToFetchMovie(description: String = "Failed to fetch a movie")
    case failedToFetchGenres(description: String = "Failed to fetch genres")
}
