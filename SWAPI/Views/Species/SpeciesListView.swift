//
//  SpeciesListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct SpeciesListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allSpecies() }
    var searching: ResourceSearching<Species> = { try await Cache.shared.search(for: $0, in: .species) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { species in
            NavigationLink(species.name, value: Route.species(species))
        }
        .navigationTitle("Species")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpeciesListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
