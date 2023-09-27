//
//  Navigation.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import Foundation

enum Route: Hashable {
    case list(Endpoint.Resource)
    case people(Person)
    case films(Film)
    case starships(Starship)
    case vehicles(Vehicle)
    case species(Species)
    case planets(Planet)
}
