//
//  MovieCardView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI

struct MovieCardView: View {
    @StateObject private var viewModel: MovieCardViewModel

    init(cardWidth: CGFloat,
         cardHeight: CGFloat,
         hasPremiere: Bool = false,
         movie: Movie) {
        let movieCardViewModel = MovieCardViewModel(cardWidth: cardWidth,
                                                    cardHeight: cardWidth,
                                                    hasPremiere: hasPremiere,
                                                    movie: movie)
        self._viewModel = StateObject(wrappedValue: movieCardViewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                AsyncImage(url: viewModel.moviePosterURL) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.25))
                            .background(.white)
                            .frame(width: viewModel.hasPremiere ? Constants.popularMovieCardWidth : Constants.nowPlayingMovieCardWidth,
                                   height: viewModel.hasPremiere ? Constants.popularMovieCardHeight : Constants.nowPlayingMovieCardHeight)
                            .overlay(alignment: .center) {
                                ProgressView()
                                    .frame(width: Constants.progressSize,
                                           height: Constants.progressSize,
                                           alignment: .center)
                                    .padding()
                            }
                    case .failure:
                        Image(systemName: Constants.questionMarkSquare)
                            .font(.headline)
                    case .success(let moviePosterImage):
                        moviePosterImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    default:
                        Image(systemName: Constants.questionMarkSquare)
                            .font(.headline)
                    }
                }
            }
            .frame(width: viewModel.hasPremiere ? Constants.popularMovieCardWidth : Constants.nowPlayingMovieCardWidth,
                   height: viewModel.hasPremiere ? Constants.popularMovieCardHeight : Constants.nowPlayingMovieCardHeight)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.movie.title)
                    .font(.setSFProText(size: 17))
                    .foregroundColor(.systemDarkWhite)

                Text(viewModel.movie.releaseDate.getFormattedDate(dateFormat: .year) ?? "")
                    .font(.setSFProText(size: 15,
                                        weight: .regular))
                    .foregroundColor(.systemGray)
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)

            if viewModel.hasPremiere {
                premiereView
            }
        }
        .frame(width: viewModel.hasPremiere ? Constants.popularMovieCardWidth : Constants.nowPlayingMovieCardWidth)
    }

    private var premiereView: some View {
        HStack {
            Image(systemName: Constants.clockImage)
                .font(.system(size: 10))

            Text(viewModel.movie.releaseDate.getFormattedDate(dateFormat: .monthDayYear) ?? "")
                .font(.setSFProText(size: 12))
        }
        .foregroundColor(.brandColor)
        .padding(.all, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.brandColor.opacity(0.25))
        )
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(cardWidth: 194,
                      cardHeight: 272,
                      movie: Movie(id: 0,
                                   posterPath: "",
                                   releaseDate: "",
                                   title: ""))
    }
}
