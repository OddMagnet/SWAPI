//
//  Film.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import Foundation

struct Film: SWAPIData {

    // MARK: Protocol conformance

    /// The identifier for the model
    var id: String { url }

    static var resource: Endpoint.Resource = .films

    func matches(term: String) -> Bool {
        title.contains(term)
    }

    // MARK: Properties

    /// The title of this film
    /// This attribute also used for searching a `Film`
    let title: String

    /// The episode number of this film.
    let episodeId: Int

    /// The opening paragraphs at the beginning of this film.
    let openingCrawl: String

    /// The name of the director of this film.
    let director: String

    /// The name(s) of the producer(s) of this film. Comma separated.
    let producer: String

    /// The ISO 8601 date format of film release at original creator country.
    let releaseDate: String

    /// the ISO 8601 date format of the time that this resource was created.
    let created: String

    /// the ISO 8601 date format of the time that this resource was edited.
    let edited: String

    /// the hypermedia URL of this resource.
    let url: String


    // TODO: flesh out model
    /// An array of species resource URLs that are in this film.
    private let species: [String]

    /// An array of starship resource URLs that are in this film.
    private let starships: [String]

    /// An array of vehicle resource URLs that are in this film.
    private let vehicles: [String]

    /// An array of people resource URLs that are in this film.
    private let characters: [String]

    /// An array of planet resource URLs that are in this film.
    private let planets: [String]
}

// MARK: - Preview

extension Film {
    static var example: Film {
        Film(title: "A New Hope",
             episodeId: 4,
             openingCrawl: """
                It is a period of civil war.

                Rebel spaceships, striking

                from a hidden base, have won

                their first victory against

                the evil Galactic Empire.



                During the battle, Rebel

                spies managed to steal secret\r\nplans to the Empire's

                ultimate weapon, the DEATH

                STAR, an armored space

                station with enough power

                to destroy an entire planet.



                Pursued by the Empire's

                sinister agents, Princess

                Leia races home aboard her

                starship, custodian of the

                stolen plans that can save her

                people and restore

                freedom to the galaxy....
                """,
             director: "George Lucas",
             producer: "Gary Kurtz, Rick McCallum",
             releaseDate: "1977-05-25",
             created: "2014-12-10",
             edited: "2014-12-12",
             url: "https://swapi.dev/api/films/1/",
             species: [],
             starships: [],
             vehicles: [],
             characters: [],
             planets: [])
    }
}
