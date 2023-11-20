//
//  FilterGenreViewModel.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import SwiftUI
import Combine

final class FilterGenreViewModel: ObservableObject {
    // MARK: - Constants
    let years = Array(1980...2023).map { String($0) }
    
    // MARK: - Properties
    @Published var showAlert = false
    @Published var searchGenre = ""
    @Published var selectedStartYear = Constants.selectedStartYear
    @Published var selectedEndYear = Constants.selectedEndYear
    @Published var selectedCategory: Int? = MovieCategory.allCases.first?.rawValue
    @Published var categoryTitles = MovieCategory.allCases.map { $0.title }
    @Published var genres = [Genre]()
    @Published var mappedGenres = [Genre]()
    @Published var numberOfGenrePerRow = 3
    
    var numberOfRows: Int {
        return (genres.count + numberOfGenrePerRow - 1) / numberOfGenrePerRow
    }
    
    var isSearching: Bool {
        return !searchGenre.isEmpty
    }
    
    // MARK: - Private properties
    @Published private(set) var alertTitle = ""
    @Published private(set) var alertMessage = ""
    @Published private(set) var isStartYearValid = false
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        $searchGenre
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.mappingGenres(searchText)
            }
            .store(in: &cancellables)
        
        $selectedStartYear
            .map { startYear in
                return startYear > self.selectedEndYear
            }
            .assign(to: \.isStartYearValid, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Methods
    func fetchGenres(movieDatabase: MovieDatabaseURL = .genre) {
        guard let url = URL(string: movieDatabase.urlString),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            showAlert(title: Constants.genreErrorTitle,
                      message: MovieListError.failedToFetchGenres().localizedDescription)
            return
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: MovieDatabaseURL.apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            showAlert(title: Constants.genreErrorTitle,
                      message: MovieListError.failedToFetchGenres().localizedDescription)
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: finalURL)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: GenreResponse.self, decoder: JSONDecoder())
            .sink { [weak self] response in
                guard let self else { return }
                switch response {
                case .failure(let error):
                    self.showAlert(title: Constants.genreErrorTitle,
                                   message: error.localizedDescription)
                default:
                    break
                }
            } receiveValue: { [weak self] genresResponse in
                self?.genres = genresResponse.genres
            }
            .store(in: &cancellables)
    }
    
    func showAlert(title: String, message: String, completion: (() -> ())? = nil) {
        alertTitle = title
        alertMessage = message
        showAlert = true
        completion?()
    }
    
    func showAlertStartedYear()  {
        showAlert(title: "Error", message: Constants.wrongStartYearMessage) { [weak self] in
            self?.selectedStartYear = Constants.selectedStartYear
        }
    }
    
    func updateSelectedGenre() {
        for index in 0..<genres.count {
            genres[index].isSelected = mappedGenres[index].isSelected
        }
    }
    
    func resetAllAction() {
        searchGenre = ""
        selectedCategory = nil
        selectedStartYear = Constants.selectedStartYear
        selectedEndYear = Constants.selectedEndYear
        if genres.count > 0 {
            for index in 0..<genres.count {
                genres[index].isSelected = false
            }
        }
    }
    
    // MARK: - Private Methods
    private func mappingGenres(_ searchText: String) {
        guard !searchText.isEmpty else {
            mappedGenres = []
            return
        }
        
        let search = searchText.lowercased()
        mappedGenres = genres.map({ genre in
            if !genre.isSelected && genre.name.lowercased().contains(search) {
                return Genre(id: genre.id,
                             name: genre.name,
                             isSelected: genre.isSelected,
                             isEqual: true)
            }
            return genre
        })
    }
}
