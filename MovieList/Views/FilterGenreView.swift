//
//  FilterGenreView.swift
//  MovieList
//
//  Created by Dmytro Besedin on 18.11.2023.
//

import SwiftUI

struct FilterGenreView: View {
    @StateObject private var viewModel = FilterGenreViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack {
                categoryView
                    .padding(.horizontal, 16)

                genreSelectionView
                    .padding(.horizontal, 16)
                genresListView

                yearSelectionView
                    .padding(.horizontal, 16)

                searchButton
                    .padding(.horizontal, 16)
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: resetAllButton)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.filtersTitle)
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        })
        .onAppear {
            viewModel.fetchGenres()
        }
        .onChange(of: viewModel.isStartYearValid) { _ in
            viewModel.showAlertStartedYear()
        }
        .onChange(of: viewModel.mappedGenres) { genres in
            if !genres.isEmpty {
                viewModel.updateSelectedGenre()
            }
        }
    }

    private var categoryView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(Constants.categoryTitle)
                .font(.setSFProText(size: 17))
                .foregroundColor(.systemDarkWhite)

            CategoryControl(selectedCategory: $viewModel.selectedCategory, categoryTitles: viewModel.categoryTitles)
        }
        .padding(.top, 16)
    }

    private var genreSelectionView: some View {
        VStack(alignment: .leading) {
            Text(Constants.gentresTitle)
                .font(.setSFProText(size: 17))
                .foregroundColor(.brandColor)

            TextField("", text: $viewModel.searchGenre)
                .modifier(TextFieldClearButton(text: $viewModel.searchGenre))
                .multilineTextAlignment(.leading)
                .frame(height: 48)
                .background(Color.systemDark)
                .cornerRadius(8)
                .tint(.brandColor)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.brandColor.opacity(0.25))
                }
        }
        .padding(.top, 16)
    }

    private var genresListView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(0..<viewModel.numberOfRows, id: \.self) { rowIndex in
                    HStack {
                        ForEach(0..<viewModel.numberOfGenrePerRow, id: \.self){ columnIndex in
                            let index = rowIndex * viewModel.numberOfGenrePerRow + columnIndex
                            if index < (viewModel.isSearching ? viewModel.mappedGenres.count :
                                    viewModel.genres.count) {
                                GenreItemView(genre: viewModel.isSearching ? $viewModel.mappedGenres[index] : $viewModel.genres[index])
                            } else {
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }

    private var yearSelectionView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.year)
                .font(.setSFProText(size: 17))
                .foregroundColor(.systemDarkWhite)

            HStack(alignment: .top) {
                YearPicker(selection: $viewModel.selectedStartYear, contentValues: viewModel.years)
                YearPicker(selection: $viewModel.selectedEndYear, contentValues: viewModel.years)
            }
        }
        .padding(.bottom, 30)
    }

    private var searchButton: some View {
        Button {
            dismiss()
        }  label: {
            HStack {
                Image(systemName: Constants.magnifyingglass)
                    .foregroundColor(.systemDarkWhite)
                    .font(.system(size: 12))

                Text(Constants.searchTitle)
                    .foregroundColor(.systemDarkWhite)
            }
            .font(.setSFProText(size: 17))
            .foregroundColor(.brandColor)
            .padding(10)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(Color.brandColor)
            .cornerRadius(30)
        }
        .padding(.bottom, 20)
    }

    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: Constants.chevronLeft)
        })
    }

    private var resetAllButton: some View {
        Button(action: {
            viewModel.resetAllAction()
        }, label: {
            Text(Constants.resetAllButtonTitle)
                .font(.setSFProText(size: 17))
                .foregroundColor(.red)
        })
    }
}

struct FilterGenreView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGenreView()
    }
}
