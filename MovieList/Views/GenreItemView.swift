//
//  GenreItemView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import SwiftUI

struct GenreItemView: View {
    @Binding var genre: Genre
    //@State var genreButtonSelected: Bool = false

    var body: some View {
        Button(action: {
            genre.isSelected.toggle()
            //self.genre.isSelected = genreButtonSelected
        }) {
            HStack {
                Text(genre.name.lowercased())
                    .font(.setSFProText(size: 17))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(genre.isSelected ? .brandColor : .systemGray)

                if genre.isSelected {
                    Image(systemName: Constants.xmark)
                        .foregroundColor(.brandColor)
                        .font(.system(size: 12))
                        .animation(.easeInOut, value: genre.isSelected)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(genre.isSelected ? Color.black : .systemDark)
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(genre.isSelected ? Color.brandColor.opacity(0.25) : .systemDark.opacity(0.25))
            )
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GenreItemView(genre: .constant(Genre.genreExample))
    }
}
