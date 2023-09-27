//
//  Cache.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import Foundation

struct Cache {
    static var shared = Cache()
    private var cachedPeople: [Person] = []
    private var cachedFilms: [Film] = []
    private var cachedStarships: [Starship] = []
    private var cachedVehicles: [Vehicle] = []
    private var cachedSpecies: [Species] = []
    private var cachedPlanets: [Planet] = []

    // MARK: - Public API

    /// Searches a resource for a given term
    /// - Parameters:
    ///   - term: the term to search for
    ///   - resource: the resource to search
    /// - Returns: an array containing the results of the search
    func search<T: Searchable>(for term: String, in resource: Endpoint.Resource) async throws -> [T] {
        let array: [T]
        // There has to be a better solution for searching the right collection
        switch resource {
        case .people:
            array = cachedPeople as? [T] ?? []
        case .films:
            array = cachedFilms as? [T] ?? []
        case .starships:
            array = cachedStarships as? [T] ?? []
        case .vehicles:
            array = cachedVehicles as? [T] ?? []
        case .species:
            array = cachedSpecies as? [T] ?? []
        case .planets:
            array = cachedPlanets as? [T] ?? []
        }

        let cachedResult = array.search(for: term)
        guard !cachedResult.isEmpty else {
            return try await API.search(for: term, in: resource)
        }
        return cachedResult
    }

    // MARK: People

    /// Checks the cache for a Person with specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Person
    /// - Returns: the Person with the ID
    func person(with id: Int) async throws -> Person {
        let cachedResult = cachedPeople.filter { $0.url == urlString(for: .people, with: id) }.first
        guard let result = cachedResult else {
            return try await API.people(with: id)
        }
        return result
    }

    /// Checks the cache for a Person with specified URL string, loads the data if necessary
    /// - Parameter withUrlString: the URL string of the Person
    /// - Returns: the Person with the URL string
    func person(withUrlString urlString: String) async throws -> Person? {
        let cachedResult = cachedPeople.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Person.self, for: url)
        }
        return result
    }

    /// Checks the cache for People, loads the data if necessary
    /// - Returns: an array of all People
    mutating func allPeople() async throws -> [Person] {
        if cachedPeople.isEmpty {
            cachedPeople = try await API.allPeople()
        }
        return cachedPeople
    }

    // MARK: Films

    /// Checks the cache for a Film with a specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Film
    /// - Returns: the Film with the ID
    func film(with id: Int) async throws -> Film {
        let cachedResult = cachedFilms.filter { $0.url == urlString(for: .films, with: id) }.first
        guard let result = cachedResult else {
            return try await API.film(with: id)
        }
        return result
    }

    /// Checks the cache for a Film with a specified URL string, loads the data if necessary
    /// - Parameter urlString: the URL string of the Film
    /// - Returns: the Film with the URL string
    func film(withUrlString urlString: String) async throws -> Film? {
        let cachedResult = cachedFilms.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Film.self, for: url)
        }
        return result
    }

    /// Checks the cache for Films, loads the data if necessary
    /// - Returns: an array of all Films
    mutating func allFilms() async throws -> [Film] {
        if cachedFilms.isEmpty {
            cachedFilms = try await API.allFilms()
        }
        return cachedFilms
    }

    // MARK: Starships

    /// Checks the cache for a Starship with a specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Starship
    /// - Returns: the Starship with the ID
    func starship(with id: Int) async throws -> Starship {
        let cachedResult = cachedStarships.filter { $0.url == urlString(for: .starships, with: id) }.first
        guard let result = cachedResult else {
            return try await API.starship(with: id)
        }
        return result
    }

    /// Checks the cache for a Starship with a specified URL string, loads the data if necessary
    /// - Parameter urlString: the URL string of the Starship
    /// - Returns: the Starship with the URL string
    func starship(withUrlString urlString: String) async throws -> Starship? {
        let cachedResult = cachedStarships.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Starship.self, for: url)
        }
        return result
    }

    /// Checks the cache for Starship, loads the data if necessary
    /// - Returns: an array of all Starship
    mutating func allStarships() async throws -> [Starship] {
        if cachedStarships.isEmpty {
            cachedStarships = try await API.allStarships()
        }
        return cachedStarships
    }

    // MARK: Vehicles

    /// Checks the cache for a Vehicle with a specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Vehicle
    /// - Returns: the Vehicle with the ID
    func vehicle(with id: Int) async throws -> Vehicle {
        let cachedResult = cachedVehicles.filter { $0.url == urlString(for: .vehicles, with: id) }.first
        guard let result = cachedResult else {
            return try await API.vehicle(with: id)
        }
        return result
    }

    /// Checks the cache for a Vehicle with a specified URL string, loads the data if necessary
    /// - Parameter urlString: the URL string of the Vehicle
    /// - Returns: the Vehicle with the URL string
    func vehicle(withUrlString urlString: String) async throws -> Vehicle? {
        let cachedResult = cachedVehicles.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Vehicle.self, for: url)
        }
        return result
    }

    /// Checks the cache for Vehicles, loads the data if necessary
    /// - Returns: an array of all Vehicles
    mutating func allVehicles() async throws -> [Vehicle] {
        if cachedVehicles.isEmpty {
            cachedVehicles = try await API.allVehicles()
        }
        return cachedVehicles
    }

    // MARK: Species

    /// Checks the cache for a Species with a specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Species
    /// - Returns: the Species with the ID
    func species(with id: Int) async throws -> Species {
        let cachedResult = cachedSpecies.filter { $0.url == urlString(for: .species, with: id) }.first
        guard let result = cachedResult else {
            return try await API.species(with: id)
        }
        return result
    }

    /// Checks the cache for a Species with a specified URL string, loads the data if necessary
    /// - Parameter urlString: the URL string of the Species
    /// - Returns: the Species with the URL string
    func species(withUrlString urlString: String) async throws -> Species? {
        let cachedResult = cachedSpecies.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Species.self, for: url)
        }
        return result
    }

    /// Checks the cache for Species, loads the data if necessary
    /// - Returns: an array of all Species
    mutating func allSpecies() async throws -> [Species] {
        if cachedSpecies.isEmpty {
            cachedSpecies = try await API.allSpecies()
        }
        return cachedSpecies
    }

    // MARK: Planets

    /// Checks the cache for a Planet with a specified ID, loads the data if necessary
    /// - Parameter id: the ID of the Planet
    /// - Returns: the Planet with the ID
    func planet(with id: Int) async throws -> Planet {
        let cachedResult = cachedPlanets.filter { $0.url == urlString(for: .planets, with: id) }.first
        guard let result = cachedResult else {
            return try await API.planet(with: id)
        }
        return result
    }

    /// Checks the cache for a Planet with a specified URL string, loads the data if necessary
    /// - Parameter urlString: the URL string of the Planet
    /// - Returns: the Planet with the URL string
    func planet(withUrlString urlString: String) async throws -> Planet? {
        let cachedResult = cachedPlanets.filter { $0.url == urlString }.first
        guard let result = cachedResult else {
            guard let url = URL(string: urlString) else {
                return nil
            }
            return try await API.fetch(Planet.self, for: url)
        }
        return result
    }

    /// Checks the cache for Planets, loads the data if necessary
    /// - Returns: an array of all Planets
    mutating func allPlanets() async throws -> [Planet] {
        if cachedPlanets.isEmpty {
            cachedPlanets = try await API.allPlanets()
        }
        return cachedPlanets
    }

    // MARK: - Helper

    private func urlString(for resource: Endpoint.Resource, with id: Int) -> String? {
        Endpoint(resource: resource, with: id).url?.absoluteString
    }
}
