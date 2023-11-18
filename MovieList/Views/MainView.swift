//
//  MainView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 16.11.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ForEach(Tab.allCases, id: \.rawValue) { item in
                item.view
                    .tabItem {
                        Image(systemName: item.image)
                        Text(item.title)
                    }
            }
        }
        .tint(.brandColor)
        .environment(\.colorScheme, .dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
