//
//  Model+Protocols.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

protocol SWAPIData: Identifiable, Hashable, Searchable, Previewable {}

protocol Searchable: Codable {
    /// The Resource for the model
    static var resource: Endpoint.Resource { get }

    /// Used as a the identifier for the model, for `Identifiable` conformance
    var url: String { get } // TODO: should be a real URL in the final app

    /// Checks if the term is contained in the models searchable data
    /// - Parameter term: the term to check for
    /// - Returns: `true` if the term is contained, false otherwise
    func matches(term: String) -> Bool
}

extension Searchable where Self: Codable {
    /// Searches for a given term
    /// - Parameter term: the term to search for
    /// - Throws: ``API/APIError/invalidURL`` when the URL from its Endpoint is invalid,
    ///           ``API/APIError/decodeError`` when the data can't be decoded into its model,
    /// - Returns: an array containing all matches
    static func search(for term: String) async throws -> [Self] {
        guard let url = Endpoint.search(for: term, in: resource).url else {
            throw API.APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResonse = response as? HTTPURLResponse {
            switch httpResonse.statusCode {
            case 400...499: throw API.APIError.clientError
            case 500...599: throw API.APIError.serverError
            default: break
            }
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let searchResult = try decoder.decode(SearchResult<Self>.self, from: data)
            return searchResult.results
        } catch {
            throw API.APIError.decodeError
        }
    }
}

extension Array where Element: Searchable {
    /// Searches the array for the given term. Useful for searches in local cache
    /// - Parameter term: the term to search for
    /// - Returns: an array containing all matches
    func search(for term: String) -> Self {
        if term.isEmpty {
            return self
        } else {
            return filter { $0.matches(term: term) }
        }
    }
}

protocol Previewable {
    static var example: Self { get }
}
