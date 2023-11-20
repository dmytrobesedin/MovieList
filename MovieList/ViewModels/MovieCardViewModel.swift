//
//  MovieCardViewModel.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI

final class MovieCardViewModel: ObservableObject {
    // MARK: - Private properties
    @Published private var cardWidth: CGFloat
    @Published private var cardHeight: CGFloat
    @Published private(set) var hasPremiere: Bool
    private(set) var movie: Movie

    // MARK: - Init
    init(cardWidth: CGFloat,
         cardHeight: CGFloat,
         hasPremiere: Bool = false,
         movie: Movie) {
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self.hasPremiere = hasPremiere
        self.movie = movie
    }

    // MARK: - Properties
    var moviePosterURL: URL? {
        guard let url = URL(string: MovieDatabaseURL.posterStorageURL(imagePath: movie.posterPath).urlString) else {
            return nil
        }
        return url
    }
}
