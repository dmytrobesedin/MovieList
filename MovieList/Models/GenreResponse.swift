//
//  Genre.swift
//  MovieList
//
//  Created by Dmytro Besedin on 20.11.2023.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Equatable {
    let id: Int
    let name: String
    var isSelected = false
    var isEqual = false

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

extension Genre {
    static let genreExample = Genre(id: 16, name: "Animation")
}
