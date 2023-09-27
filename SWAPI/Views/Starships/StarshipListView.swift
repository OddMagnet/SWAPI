//
//  StarshipListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct StarshipListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allStarships() }
    var searching: ResourceSearching<Starship> = { try await Cache.shared.search(for: $0, in: .starships) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { ship in
            NavigationLink(ship.name, value: Route.starships(ship))
        }
        .navigationTitle("Starships")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StarshipListView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipListView()
    }
}
