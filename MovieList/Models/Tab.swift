//
//  Tab.swift
//  MovieList
//
//  Created by Dmytro Besedin on 16.11.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case search
    case favorites
    case account

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            HomeView()
        case .search:
            Text(Tab.search.title)
        case .favorites:
            Text(Tab.favorites.title)
        case .account:
            Text(Tab.account.title)
        }
    }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .favorites:
            return "Favorites"
        case .account:
            return "Account"
        }
    }

    var image: String {
        switch self {
        case .home:
            return "film.fill"
        case .search:
            return "magnifyingglass"
        case .favorites:
            return "heart"
        case .account:
            return "person"
        }
    }
}
