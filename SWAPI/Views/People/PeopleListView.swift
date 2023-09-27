//
//  PeopleListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 24.09.23.
//

import SwiftUI

struct PeopleListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allPeople() }
    var searching: ResourceSearching<Person> = { try await Cache.shared.search(for: $0, in: .people) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { person in
            NavigationLink(person.name, value: Route.people(person))
        }
        .navigationTitle("People")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView()
    }
}
