//
//  Endpoint.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

struct Endpoint {
    enum Resource: String, CaseIterable, Identifiable {
        case people
        case planets
        case films
        case species
        case vehicles
        case starships

        var id: Resource { self }

        var capitalized: String {
            rawValue.capitalized
        }
    }

    let path: String
    let queryItems: [URLQueryItem]?

    init(resource: Resource, with id: Int? = nil, queryItems: [URLQueryItem]? = nil) {
        self.path = Self.path(for: resource, with: id)
        self.queryItems = queryItems
    }

    // MARK: - Helper

    private static func path(for resource: Resource, with id: Int? = nil) -> String {
        var path = resource.rawValue
        if let id {
            path.append("/\(id)/")
        }
        return path
    }
}

// MARK: - Factory Methods

extension Endpoint {
    static func search(for term: String, in resource: Endpoint.Resource) -> Endpoint {
        Endpoint(
            resource: resource,
            queryItems: [
                URLQueryItem(name: "search", value: term)
            ]
        )
    }

    static func people(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .people, with: id)
    }

    static func films(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .films, with: id)
    }

    static func starships(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .starships, with: id)
    }

    static func vehicles(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .vehicles, with: id)
    }

    static func species(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .species, with: id)
    }

    static func planets(with id: Int? = nil) -> Endpoint {
        Endpoint(resource: .planets, with: id)
    }
}

// MARK: - URL creation

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "swapi.dev"
        components.path = "/api/\(path)"
        components.queryItems = queryItems

        return components.url
    }
}
