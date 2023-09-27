//
//  PlanetOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct PlanetOverviewView: View {
    let planet: Planet

    var body: some View {
        VStack {
            Text(planet.name)
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlanetOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetOverviewView(planet: .example)
    }
}
