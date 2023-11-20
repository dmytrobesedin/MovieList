//
//  HomeViewModel.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published var showAlert = false
    
    // MARK: - Private properties
    @Published private(set) var nowPlayingMovies = [Movie]()
    @Published private(set) var popularMovies = [Movie]()
    @Published private(set) var state: LoadingState = .empty
    @Published private(set) var alertTitle = ""
    @Published private(set) var alertMessage = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    func setMovies() {
        fetchMovies(movieDatabase: .nowPlaying) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
        
        fetchMovies(movieDatabase: .popular) { [weak self] movies in
            self?.popularMovies = movies
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - Private methods
    private func fetchMovies(movieDatabase: MovieDatabaseURL, completion: @escaping ([Movie]) -> Void) {
        state = .loading
        guard let url = URL(string: movieDatabase.urlString),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            self.state = .empty
            return
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: MovieDatabaseURL.apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            self.state = .empty
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: finalURL)
            .receive(on: DispatchQueue.main)
            .tryMap { response in
                guard let res = response.response as? HTTPURLResponse,
                      res.statusCode >= 200 && res.statusCode <= 300 else {
                    throw MovieListError.invalidStatusCode()
                }
                
                let decoder = JSONDecoder()
                guard let moviesData = try? decoder.decode(MovieResponse.self, from: response.data) else {
                    throw MovieListError.failedToDecode()
                }
                return moviesData.results
            }
            .sink { [weak self] response in
                guard let self else { return }
                
                switch response {
                case .failure(let error):
                    self.state = .empty
                    self.showAlert(title: MovieListError.failedToFetchMovie().localizedDescription,
                                   message: error.localizedDescription)
                case .finished:
                    self.state = .content
                }
                
            } receiveValue: { movies in
                completion(movies)
            }
            .store(in: &cancellables)
    }
}
