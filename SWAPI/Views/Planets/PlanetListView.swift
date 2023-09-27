//
//  PlanetListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct PlanetListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allPlanets() }
    var searching: ResourceSearching<Planet> = { try await Cache.shared.search(for: $0, in: .planets) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { planet in
            NavigationLink(planet.name, value: Route.planets(planet))
        }
        .navigationTitle("Planets")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
