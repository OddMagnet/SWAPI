//
//  FilmOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct FilmOverviewView: View {
    let film: Film

    var body: some View {
        VStack {
            Text(film.title)
        }
        .navigationTitle(film.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct FilmOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        FilmOverviewView(film: .example)
    }
}
