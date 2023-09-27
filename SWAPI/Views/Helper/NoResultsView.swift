//
//  NoResultsView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

/// A Helper View for displaying a "No results" screen
struct NoResultsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()

            Text("Sorry, no results. Check your search or Internet connection")

            Spacer()

            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView()
    }
}
