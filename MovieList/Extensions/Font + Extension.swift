//
//  Font + Extension.swift
//  MovieList
//
//  Created by Dmytro Besedin on 18.11.2023.
//

import SwiftUI

extension Font {
    static func setSFProDisplay(size: CGFloat, weight: Weight) -> Font {
        return Font.custom("SF Pro Display", size: size)
            .weight(weight)
    }

    static func setSFProText(size: CGFloat, weight: Weight = .regular) -> Font {
        return Font.custom("SF Pro Text", size: size)
            .weight(weight)
    }
}
