//
//  CategoryControl.swift
//  MovieList
//
//  Created by Dmytro Besedin on 18.11.2023.
//

import SwiftUI

struct CategoryControl: View {
    @Binding var selectedCategory: Int?
    var categoryTitles: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0 ..< categoryTitles.count, id: \.self) { index in
                    Button(action: {
                        if selectedCategory == index {
                            selectedCategory = nil
                        } else {
                            selectedCategory = index
                        }
                    }) {
                        Text(categoryTitles[index])
                            .font(.setSFProText(size: 17))
                            .foregroundColor(selectedCategory == index ? Color.systemDarkWhite : .systemGray)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedCategory == index ? Color.brandColor : .systemDark)
                            .cornerRadius(100)
                    }
                }
            }
        }
    }
}

struct CategoryControl_Previews: PreviewProvider {
    static var previews: some View {
        CategoryControl(selectedCategory: .constant(0),
                        categoryTitles: ["Movies", "Cartoons", "TV Series"])
    }
}
