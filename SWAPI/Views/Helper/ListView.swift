//
//  ListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

/// A Helper View to return the right ListView for a given Resource
struct ListView: View {
    let resource: Endpoint.Resource

    @ViewBuilder var body: some View {
        switch resource {
        case .people: PeopleListView()
        case .planets: PlanetListView()
        case .films: FilmListView()
        case .species: SpeciesListView()
        case .vehicles: VehicleListView()
        case .starships: StarshipListView()
        }
    }
}
