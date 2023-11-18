//
//  LoadingView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Loading..")

                ProgressView()
                    .scaleEffect(1.5)
                    .padding(.top, 25)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
