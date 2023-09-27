//
//  PersonOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import SwiftUI

struct PersonOverviewView: View {
    let person: Person
    @State private var homeWorld: Planet?
    @State private var films: [Film]? = []
    @State private var species: [Species]? = []
    @State private var starships: [Starship]? = []
    @State private var vehicles: [Vehicle]? = []

    var body: some View {
        Form {
            Section("General Info") {
                InfoRow(title: "Name", info: person.name)
                InfoRow(title: "BirthYear", info: person.birthYear)
                InfoRow(title: "Eye color", info: person.eyeColor)
                InfoRow(title: "Gender", info: person.gender)
                InfoRow(title: "Hair color", info: person.hairColor)
                InfoRow(title: "Height (cm)", info: person.height)
                InfoRow(title: "Mass (kg)", info: person.mass)
                InfoRow(title: "Skin color", info: person.skinColor)
            }

            LoadingSection("Homeworld", item: homeWorld) { planet in
                NavigationLink(planet.name, value: Route.planets(planet))
            }

            LoadingSection("Films", items: films) { film in
                NavigationLink(film.title, value: Route.films(film))
            }

            LoadingSection("Species", items: species) { species in
                NavigationLink(species.name, value: Route.species(species))
            }

            LoadingSection("Starships", items: starships) { ship in
                NavigationLink(ship.name, value: Route.starships(ship))
            }

            LoadingSection("Vehicles", items: vehicles) { vehicle in
                NavigationLink(vehicle.name, value: Route.vehicles(vehicle))
            }

            Section("Metadata") {
                InfoRow(title: "Created", info: person.created)
                InfoRow(title: "Edited", info: person.edited)
                InfoRow(title: "API-URL", info: person.url)
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchData)
    }

    func fetchData() {
        Task {
            homeWorld = try await person.homeworldPlanet
            films = try await person.filmsPlayedIn
            species = try await person.speciesPersonBelongsTo
            starships = try await person.pilotedStarships
            vehicles = try await person.pilotedVehicles
        }
    }
}

struct PersonOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        PersonOverviewView(person: .example)
    }
}
