//
//  InfoRow.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

/// A Helper View for displaying model data
struct InfoRow: View {
    let title: String
    let info: String

    var body: some View {
        HStack {
            Text(title)

            Spacer()

            Text(info)
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Title", info: "Info")
    }
}
