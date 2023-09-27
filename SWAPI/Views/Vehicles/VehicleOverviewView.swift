//
//  VehicleOverviewView.swift
//  SWAPI
//
//  Created by Michael Brünen on 25.09.23.
//

import SwiftUI

struct VehicleOverviewView: View {
    let vehicle: Vehicle

    var body: some View {
        VStack {
            Text(vehicle.name)
        }
        .navigationTitle(vehicle.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VehicleOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleOverviewView(vehicle: .example)
    }
}
