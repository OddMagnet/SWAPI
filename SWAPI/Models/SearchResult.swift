//
//  Search.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

/// Model type used for both all results of a Resource as well as
/// search results of a resource
struct SearchResult<T: Codable>: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
