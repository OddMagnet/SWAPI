//
//  LoadingSection.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI


struct LoadingSection<Element: Identifiable & Equatable, RowContent: View>: View {
    let name: String
    var items: [Element]?
    private var rowContent: (Element) -> RowContent

    /// A SectionView that shows a loading indicator while its content is being fetched
    /// Displays a placeholder text if `items` is nil
    /// - Parameters:
    ///   - name: the name of the section
    ///   - items: the items for the section, can be nil
    ///   - rowContent: the row content, takes an item
    public init(_ name: String,
                items: [Element]?,
                @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.name = name
        self.items = items
        self.rowContent = rowContent
    }

    /// A SectionView that shows a loading indicator while its content is being fetched
    /// Displays a placeholder text if `item` is nil
    /// - Parameters:
    ///   - name: the name of the section
    ///   - item: the single item of the section, can be nil
    ///   - rowContent: the row content, takes an item
    public init(_ name: String,
                item: Element?,
                @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.name = name
        if let item {
            self.items = [item]
        } else {
            self.items = []
        }
        self.rowContent = rowContent
    }

    var body: some View {
        Section(name) {
            if let items {
                if items.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }

                List(items, rowContent: rowContent)
            } else {
                Text("No entry")
            }
        }
    }
}
