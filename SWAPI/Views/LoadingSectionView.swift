//
//  LoadingSectionView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI


struct LoadingSection<Element: Identifiable & Equatable, RowContent: View>: View {
    let name: String
    var items: [Element]
    private var rowContent: (Element) -> RowContent

    public init(_ name: String,
                items: [Element],
                @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.name = name
        self.items = items
        self.rowContent = rowContent
    }

    var body: some View {
        Section(name) {
            if items.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }

            List(items, rowContent: rowContent)
        }
    }
}
