//
//  MovieCategory.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import Foundation

enum MovieCategory: Int, CaseIterable, Codable {
    case movies
    case cartoons
    case tvSeries

    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .cartoons:
            return "Cartoons"
        case .tvSeries:
            return "TV Series"
        }
    }
}
