//
//  TextFieldClearButton.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            Spacer()
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: Constants.xmark)
                            .foregroundColor(.brandColor)
                            .font(.system(size: 15))
                    }
                )
            }
        }
        .padding(.horizontal)
    }
}

