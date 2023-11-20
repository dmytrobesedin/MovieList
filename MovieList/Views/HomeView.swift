//
//  HomeView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 16.11.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .navigationBarTitleDisplayMode(.inline)
                case .empty:
                    EmptyView()
                case .content:
                    content
                }
            }
            .onAppear {
                viewModel.setMovies()
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                greetingView
                
                nowPlayingView
                
                popularView
            }
            .padding(.top, 16)
        }
    }
    
    private var greetingView: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(Constants.welcomeTitle)
                    .font(.setSFProDisplay(size: 28,
                                           weight: .medium))
                    .foregroundColor(.brandColor)
                
                Text(Constants.welcomeDescription)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
                    .font(.setSFProText(size: 15))
                    .foregroundColor(.systemGray)
            }
            .frame(width: Constants.greetingViewWidth,
                   height: Constants.greetingViewHeight,
                   alignment: .leading)
            
            NavigationLink {
                FilterGenreView()
                    .toolbar(.hidden, for: .tabBar)
            } label: {
                Image(Constants.filterButton)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var nowPlayingView: some View {
        HomeSectionView(title: Constants.nowPlayingTitle,
                        movieCarWidth: Constants.nowPlayingMovieCardWidth,
                        movieCardHeight: Constants.nowPlayingMovieCardHeight,
                        movies: viewModel.nowPlayingMovies)
    }
    
    private var popularView: some View {
        HomeSectionView(title: Constants.popularTitle,
                        movieCarWidth: Constants.popularMovieCardWidth,
                        movieCardHeight: Constants.popularMovieCardHeight,
                        hasPremiere: true,
                        movies: viewModel.popularMovies)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
