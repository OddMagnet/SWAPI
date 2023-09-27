//
//  LoadingList.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

typealias ResourceLoading<T> = () async throws -> [T]
typealias ResourceSearching<T> = (String) async throws -> [T]

struct LoadingList<Element: Identifiable & Equatable, RowContent: View>: View {
    @State private var items: [Element] = []
    @State private var searchTerm: String = ""
    @State private var searchTask: Task<Void, Error>?
    @State private var showNoResults: Bool = false

    private var loadingClosure: () async throws -> [Element]
    private var searchClosure: (String) async throws -> [Element]
    private var rowContent: (Element) -> RowContent

    /// A ListView that shows a loading indicator while its content is being fetched
    /// - Parameters:
    ///   - loadingClosure: the closure that loads the Lists data
    ///   - searchClosure: the closure that is executed for a search
    ///   - rowContent: the row content, takes an item
    public init(loadingClosure: @escaping ResourceLoading<Element>,
                searchClosure: @escaping ResourceSearching<Element>,
                @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.loadingClosure = loadingClosure
        self.searchClosure = searchClosure
        self.rowContent = rowContent
    }

    var body: some View {
        List(items, rowContent: rowContent)
            .overlay {
                if items.isEmpty {
                    ProgressView("Fetching data, please wait...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
            .animation(.default, value: items)
            .onAppear(perform: loadData)
            .refreshable(action: refresh)
            .searchable(text: $searchTerm)
            .onChange(of: searchTerm, perform: searchFor)
            .sheet(isPresented: $showNoResults) {
                NoResultsView()
            }
    }

    func loadData() {
        Task {
            items = try await loadingClosure()
        }
    }

    @Sendable
    func refresh() async {
        if let result = try? await loadingClosure() {
            items = result
        }
    }

    func searchFor(term: String) {
        searchTask?.cancel()

        searchTask = Task {
            try await Task.sleep(for: .seconds(0.4))
            items = []
            let result = try await searchClosure(term)
            if result.isEmpty {
                showNoResults = true
                searchTerm = ""
            }
            items = result
        }
    }
}
