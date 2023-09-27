//
//  FilmListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import SwiftUI

struct FilmListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allFilms() }
    var searching: ResourceSearching<Film> = { try await Cache.shared.search(for: $0, in: .films) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { film in
            NavigationLink(film.title, value: Route.films(film))
        }
        .navigationTitle("Films")
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}
