//
//  MovieListError.swift
//  MovieList
//
//  Created by Dmytro Besedin on 14.11.2023.
//

import Foundation

enum MovieListError: Error {
   // static let movieCardError = "Movie card error"
    //case invalidURL(description: String = "Invalid URL.")
 //   case invalidMovie(description: String = "Invalid movie.")
  //  case invalidResponseData(description: String = "Invalid response data.")
    //  case invalidMoviePoster(description: String = "Invalid movie poster.")
    case failedToDecode(description: String = "Failed to decode.")
    case invalidStatusCode(description: String = "Invalid status code.")
    case failedToFetchMovie(description: String = "Failed to fetch a movie")
}
