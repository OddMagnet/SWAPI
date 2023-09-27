//
//  StarshipOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct StarshipOverviewView: View {
    let ship: Starship

    var body: some View {
        VStack {
            Text(ship.name)
        }
        .navigationTitle(ship.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StarshipOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipOverviewView(ship: .example)
    }
}
