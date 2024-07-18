//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Logan Miller on 7/17/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let allPredators = Predators()
    
    @State var satelite: Bool = false
    @State var position: MapCameraPosition
    
    var body: some View {
        Map(position: $position) {
            ForEach(allPredators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(satelite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelite.toggle()
            } label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
            }
            .font(.largeTitle)
            .imageScale(.large)
            .padding(3)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 8))
            .shadow(radius: 3)
            .padding()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[0].location, distance: 1000,
                                               heading: 250,
                                               pitch: 80)))
    .preferredColorScheme(.dark)
}
