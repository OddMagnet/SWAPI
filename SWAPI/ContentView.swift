//
//  ContentView.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import SwiftUI

struct ContentView: View {
    @State private var navigationPath: [Route] = []

    var body: some View {
        VStack {
            NavigationStack(path: $navigationPath) {
                List(Endpoint.Resource.allCases) { resource in
                    NavigationLink(resource.capitalized, value: Route.list(resource))
                }
                .navigationTitle("SWAPI")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .list(resource):
                        ListView(resource: resource)
                    case let .people(person):
                        PersonOverviewView(person: person)
                    case let .films(film):
                        FilmOverviewView(film: film)
                    case let .starships(ship):
                        StarshipOverviewView(ship: ship)
                    case let .vehicles(vehicle):
                        VehicleOverviewView(vehicle: vehicle)
                    case let .species(species):
                        SpeciesOverviewView(species: species)
                    case let .planets(planet):
                        PlanetOverviewView(planet: planet)
                    }
                }
            }

            if !navigationPath.isEmpty {
                Button("Home") {
                    navigationPath = []
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
