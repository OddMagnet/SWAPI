//
//  Person.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

struct Person: SWAPIData {

    // MARK: - Protocol conformance

    /// The identifier for the model
    var id: String { url }

    static var resource: Endpoint.Resource = .people

    func matches(term: String) -> Bool {
        name.contains(term)
    }

    // MARK: - Properties

    /// The name of this person.
    /// This attribute also used for searching a `Person`
    let name: String

    /// The birth year of the person, using the in-universe standard of BBY or ABY -
    /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin
    /// is a battle that occurs at the end of Star Wars episode IV: A New Hope.
    let birthYear: String

    /// The eye color of this person. Will be "unknown" if not known or "n/a"
    /// if the person does not have an eye.
    let eyeColor: String

    /// The gender of this person. Either "Male", "Female" or "unknown", "n/a"
    /// if the person does not have a gender.
    let gender: String

    /// The hair color of this person. Will be "unknown" if not known or "n/a"
    /// if the person does not have hair.
    let hairColor: String

    /// The height of the person in centimeters.
    let height: String

    /// The mass of the person in kilograms.
    let mass: String

    /// The skin color of this person.
    let skinColor: String

    /// the ISO 8601 date format of the time that this resource was created.
    let created: String

    /// the ISO 8601 date format of the time that this resource was edited.
    let edited: String

    /// the hypermedia URL of this resource.
    let url: String


    /// The URL of a planet resource, a planet that this person was born on or inhabits.
    private let homeworld: String
    /// This persons homeworld
    var homeworldPlanet: Planet? {
        get async throws {
            try await Cache.shared.planet(withUrlString: homeworld)
        }
    }

    /// An array of film resource URLs that this person has been in.
    private let films: [String]
    /// The films this person has been in
    var filmsPlayedIn: [Film]? {
        get async throws {
            let result = try await films.asyncCompactMap { filmURL in
                try await Cache.shared.film(withUrlString: filmURL)
            }
            return result.isEmpty ? nil : result
        }
    }

    /// An array of species resource URLs that this person belongs to.
    private let species: [String]
    /// The species this persons belongs to
    var speciesPersonBelongsTo: [Species]? {
        get async throws {
            let result = try await species.asyncCompactMap { speciesURL in
                try await Cache.shared.species(withUrlString: speciesURL)
            }
            return result.isEmpty ? nil : result
        }
    }

    /// An array of starship resource URLs that this person has piloted.
    private let starships: [String]
    /// The starships this person has piloted
    var pilotedStarships: [Starship]? {
        get async throws {
            let result = try await starships.asyncCompactMap { shipURL in
                try await Cache.shared.starship(withUrlString: shipURL)
            }
            return result.isEmpty ? nil : result
        }
    }

    /// An array of vehicle resource URLs that this person has piloted.
    private let vehicles: [String]
    /// The vehicles this person has piloted
    var pilotedVehicles: [Vehicle]? {
        get async throws {
            let result = try await vehicles.asyncCompactMap { vehicleURL in
                try await Cache.shared.vehicle(withUrlString: vehicleURL)
            }
            return result.isEmpty ? nil : result
        }
    }
}

// MARK: Preview

extension Person {
    static var example: Person {
        Person(name: "Luke Skywalker",
               birthYear: "19BBY",
               eyeColor: "blue",
               gender: "male",
               hairColor: "blond",
               height: "172",
               mass: "77",
               skinColor: "fair",
               created: "2014-12-09",
               edited: "2014-12-20",
               url: "https://swapi.dev/api/people/1/",
               homeworld: "Tatooine",
               films: [],
               species: [],
               starships: [],
               vehicles: [])
    }
}
