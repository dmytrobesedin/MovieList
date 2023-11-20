//
//  HomeSectionView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI

struct HomeSectionView: View {
    var title: String
    var movieCarWidth: CGFloat
    var movieCardHeight: CGFloat
    var hasPremiere = false
    let movies: [Movie]

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center) {
                Text(title)
                    .font(.setSFProDisplay(size: 20, weight: .medium))
                    .foregroundColor(.systemDarkWhite)
                Spacer()

                Button {

                } label: {
                    Text(Constants.seeAllButtonTitle)
                        .font(.setSFProText(size: 15))
                        .foregroundColor(.systemGray)
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(movies, id: \.id) { movie in
                        MovieCardView(cardWidth: movieCarWidth,
                                      cardHeight: movieCardHeight,
                                      hasPremiere: hasPremiere,
                                      movie: movie)
                        .padding(.leading, movie.id == movies.first?.id ? 16 : 0)
                        .padding(.trailing, movie.id == movies.last?.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct HomeSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSectionView(title: "title",
                        movieCarWidth: 174,
                        movieCardHeight: 165,
                        movies: [Movie(id: 0,
                                       posterPath: "",
                                       releaseDate: "",
                                       title: "")])
    }
}
