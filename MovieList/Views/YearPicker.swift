//
//  YearPicker.swift
//  MovieList
//
//  Created by Dmytro Besedin on 19.11.2023.
//

import SwiftUI

struct YearPicker: View {
    @Binding var selection: String
    let contentValues: [String]
    
    var body: some View {
        Menu {
            Picker(selection: $selection, content: {
                ForEach(contentValues, id: \.self) { value in
                    Text(value)
                        .tag(value)
                }
            }, label: {
                EmptyView()
            })
            .pickerStyle(.inline)
            .labelsHidden()
        } label: {
            HStack(spacing: 60) {
                Text(selection)
                Image(systemName: Constants.chevronDown)
            }
            .font(.setSFProText(size: 17))
            .foregroundColor(.systemDarkGray)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color.systemDark)
            .cornerRadius(8)
        }
    }
}

struct YearPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearPicker(selection: .constant("2021"),
                   contentValues: ["2021", "2022", "2023"])
    }
}
