//
//  DateFormat.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import Foundation

enum DateFormat {
    case yearMonthDay
    case year
    case monthDayYear
    
    var format: String {
        switch self {
        case .yearMonthDay:
            return "yyyy-MM-d"
        case .year:
            return "yyyy"
        case .monthDayYear:
            return "MMM d, yyyy"
        }
    }
}
