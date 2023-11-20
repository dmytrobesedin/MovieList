//
//  GenreItemView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import SwiftUI

struct GenreItemView: View {
    @Binding var genre: Genre
    
    var body: some View {
        Button(action: {
            genre.isSelected.toggle()
            genre.isEqual = false
        }) {
            HStack(alignment: .center, spacing: 4) {
                Text(genre.name.lowercased())
                    .font(.setSFProText(size: 17))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(genre.isSelected ? .brandColor : (genre.isEqual ? .systemDarkWhite : .systemGray))
                
                if genre.isSelected {
                    Image(systemName: Constants.xmark)
                        .foregroundColor(.brandColor)
                        .font(.system(size: 10))
                        .animation(.easeInOut, value: genre.isSelected)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(genre.isSelected ? Color.black : (genre.isEqual ? .brandColor : .systemDark))
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(genre.isSelected ? Color.brandColor.opacity(0.25) :(genre.isEqual ? .brandColor.opacity(0.25) : .systemDark.opacity(0.25)) )
            )
        }
        .onChange(of: genre.isSelected) { _ in
            genre.isEqual = false
        }
    }
}

struct GenreItemView_Previews: PreviewProvider {
    static var previews: some View {
        GenreItemView(genre: .constant(Genre.genreExample))
    }
}
