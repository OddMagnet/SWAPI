//
//  API.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

struct API {
    enum APIError: Error {
        case invalidURL
        case decodeError
        case clientError
        case serverError
        case other
    }

    // MARK: - Public API

    static func search<T: Searchable>(for term: String, in resource: Endpoint.Resource) async throws -> [T] {
        try await T.search(for: term)
    }

    // MARK: People

    static func people(with id: Int) async throws -> Person {
        return try await fetch(Person.self, for: .people(with: id))
    }

    static func allPeople() async throws -> [Person] {
        let searchResults = try await fetch(SearchResult<Person>.self, for: .people())
        return searchResults.results
    }

    // MARK: Films

    static func film(with id: Int) async throws -> Film {
        return try await fetch(Film.self, for: .films(with: id))
    }

    static func allFilms() async throws -> [Film] {
        let searchResults = try await fetch(SearchResult<Film>.self, for: .films())
        return searchResults.results
    }

    // MARK: Starships

    static func starship(with id: Int) async throws -> Starship {
        return try await fetch(Starship.self, for: .starships(with: id))
    }

    static func allStarships() async throws -> [Starship] {
        let searchResults = try await fetch(SearchResult<Starship>.self, for: .starships())
        return searchResults.results
    }

    // MARK: Vehicles

    static func vehicle(with id: Int) async throws -> Vehicle {
        return try await fetch(Vehicle.self, for: .vehicles(with: id))
    }

    static func allVehicles() async throws -> [Vehicle] {
        let searchResults = try await fetch(SearchResult<Vehicle>.self, for: .vehicles())
        return searchResults.results
    }

    // MARK: Species

    static func species(with id: Int) async throws -> Species {
        return try await fetch(Species.self, for: .species(with: id))
    }

    static func allSpecies() async throws -> [Species] {
        let searchResults = try await fetch(SearchResult<Species>.self, for: .species())
        return searchResults.results
    }

    // MARK: Planets

    static func planet(with id: Int) async throws -> Planet {
        return try await fetch(Planet.self, for: .planets(with: id))
    }

    static func allPlanets() async throws -> [Planet] {
        let searchResults = try await fetch(SearchResult<Planet>.self, for: .planets())
        return searchResults.results
    }

    // MARK: - Private Helpers

    static func fetch<T: Codable>(_ type: T.Type, for endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }

        return try await fetch(type, for: url)
    }

    static func fetch<T: Codable>(_ type: T.Type, for url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResonse = response as? HTTPURLResponse {
            switch httpResonse.statusCode {
            case 400...499: throw APIError.clientError
            case 500...599: throw APIError.serverError
            default: break
            }
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let result = try decoder.decode(type, from: data)
            return result
        } catch {
            throw APIError.decodeError
        }
    }
}
