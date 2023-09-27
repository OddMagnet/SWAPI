//
//  SpeciesOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct SpeciesOverviewView: View {
    let species: Species

    var body: some View {
        VStack {
            Text(species.name)
        }
        .navigationTitle(species.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpeciesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesOverviewView(species: .example)
    }
}
