//
//  String + Extension.swift
//  MovieList
//
//  Created by Dmytro Besedin on 17.11.2023.
//

import SwiftUI

extension String {
    func getFormattedDate(dateFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yearMonthDay.format
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        dateFormatter.dateFormat = dateFormat.format
        return dateFormatter.string(from: date)
    }
}

