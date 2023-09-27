//
//  Vehicle.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import Foundation

struct Vehicle: SWAPIData {

    // MARK: Protocol conformance

    /// The identifier for the model
    var id: String { url }

    static var resource: Endpoint.Resource = .vehicles

    func matches(term: String) -> Bool {
        name.contains(term) || model.contains(term)
    }

    // MARK: Properties

    /* TODO: flesh out model & OverviewView
     Attributes:
     name string -- The name of this vehicle. The common name, such as "Sand Crawler" or "Speeder bike".
     model string -- The model or official name of this vehicle. Such as "All-Terrain Attack Transport".
     vehicle_class string -- The class of this vehicle, such as "Wheeled" or "Repulsorcraft".
     manufacturer string -- The manufacturer of this vehicle. Comma separated if more than one.
     length string -- The length of this vehicle in meters.
     cost_in_credits string -- The cost of this vehicle new, in Galactic Credits.
     crew string -- The number of personnel needed to run or pilot this vehicle.
     passengers string -- The number of non-essential people this vehicle can transport.
     max_atmosphering_speed string -- The maximum speed of this vehicle in the atmosphere.
     cargo_capacity string -- The maximum number of kilograms that this vehicle can transport.
     consumables *string
     The maximum length of time that this vehicle can provide consumables for its entire crew
        without having to resupply.
     films array -- An array of Film URL Resources that this vehicle has appeared in.
     pilots array -- An array of People URL Resources that this vehicle has been piloted by.
     url string -- the hypermedia URL of this resource.
     created string -- the ISO 8601 date format of the time that this resource was created.
     edited string -- the ISO 8601 date format of the time that this resource was edited.

     Search Fields:
     name
     model
     */

    let name: String
    let model: String
    let url: String
}

// MARK: - Preview

extension Vehicle {
    static var example: Vehicle {
        Vehicle(name: "VEHICLE", model: "MODEL", url: "URL")
    }
}
