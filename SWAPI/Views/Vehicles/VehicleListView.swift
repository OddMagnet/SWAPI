//
//  VehicleListView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct VehicleListView: View {
    var loading: ResourceLoading = { try await Cache.shared.allVehicles() }
    var searching: ResourceSearching<Vehicle> = { try await Cache.shared.search(for: $0, in: .vehicles) }

    var body: some View {
        LoadingList(loadingClosure: loading,
                        searchClosure: searching) { vehicle in
            NavigationLink(vehicle.name, value: Route.vehicles(vehicle))
        }
        .navigationTitle("Vehicles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
